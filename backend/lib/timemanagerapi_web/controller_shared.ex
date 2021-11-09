defmodule TimeManagerAPIWeb.Shared do
  import Plug.Conn

  def get_relation(list, relation) when is_list(list) do
    list
    |> Enum.map(fn x -> TimeManagerAPI.Repo.preload(x, relation) end)
    |> Enum.map(fn x -> Map.get(x, relation) end)
  end

  def get_relation(item, relation) do
    item
    |> TimeManagerAPI.Repo.preload(relation)
    |> Map.get(relation)
  end

  def create_datetime(input) do
    split = String.split(input)

    if Enum.count(split) != 2 do
      {:error, "Invalid format"}
    else
      left = split |> Enum.at(0) |> String.split("-")
      right = split |> Enum.at(1) |> String.split(":")

      parse = fn x -> x |> Integer.parse() |> elem(0) end

      if Enum.count(left) != 3 and Enum.count(right) != 3 do
        {:error, "Invalid format"}
      else
        mydate = left |> Enum.map(parse)
        mytime = right |> Enum.map(parse)

        # Returns a {:ok, NaiveDateTime} or a {:error, reason} by itself
        NaiveDateTime.new(
          mydate |> Enum.at(0),
          mydate |> Enum.at(1),
          mydate |> Enum.at(2),
          mytime |> Enum.at(0),
          mytime |> Enum.at(1),
          mytime |> Enum.at(2)
        )
      end
    end
  end

  def datetime_to_string(d) do
    "#{d.year}-#{d.month}-#{d.day} #{d.hour}:#{d.minute}:#{d.second}"
  end

  def extract_users_from_query(list) do
    list |> Enum.map(&extract_user_from_query/1)
  end

  def extract_user_from_query([head | tail]) when tail == [] do
    extract_user_from_query(head)
  end

  def extract_user_from_query(head) do
    %{
      id: head.id,
      username: head.username,
      email: head.email,
      role: head.role
    }
  end

  def extract_clock_from_query([head | tail]) when tail == [] do
    %{
      id: head.id,
      status: head.status,
      user: head.user_id,
      time: head.time |> datetime_to_string()
    }
  end

  def extract_clock_from_query(head) do
    %{
      id: head.id,
      status: head.status,
      user: head.user_id,
      time: head.time |> datetime_to_string()
    }
  end

  def extract_workingtime_from_query([head | tail]) when tail == [] do
    %{
      id: head.id,
      start: head.start |> datetime_to_string(),
      end: head.end |> datetime_to_string(),
      user: head.user_id
    }
  end

  def extract_workingtime_from_query(head) do
    %{
      id: head.id,
      start: head.start |> datetime_to_string(),
      end: head.end |> datetime_to_string(),
      user: head.user_id
    }
  end

  def extract_workingtimes_from_query(elems) when is_list(elems) do
    elems
    |> Enum.map(&extract_workingtime_from_query/1)
  end

  def extract_team_from_query([head | tail]) when tail == [] do
    %{
      id: head.id,
      name: head.name
    }
  end

  def extract_team_from_query(elem) do
    %{
      id: elem.id,
      name: elem.name
    }
  end

  def extract_teams_from_query(elems) when is_list(elems) do
    elems
    |> Enum.map(&extract_team_from_query/1)
  end

  def add_user_to_team(team, user) do
    team = team |> TimeManagerAPI.Repo.preload(:users)

    changes =
      team
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:users, [user | team.users])
      |> TimeManagerAPI.Repo.update()

    case changes do
      {:ok, team} -> {:ok, extract_team_from_query(team)}
      {:error, _} -> {:error, "Error when updating team"}
    end
  end

  def render_json({:ok, elem}) do
    {200,
    Jason.encode(elem)
    |> elem(1)}
  end

  def render_json({:error, message}) do
    {400,
    Jason.encode(%{message: message})
    |> elem(1)}
  end

  def send_response({status, content}, conn) do
    send_resp(conn, status, content)
  end
end
