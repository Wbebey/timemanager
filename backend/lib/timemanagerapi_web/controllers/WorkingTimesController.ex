defmodule TimeManagerAPIWeb.WorkingTimesController do
  use TimeManagerAPIWeb, :controller
  import TimeManagerAPIWeb.Shared
  import Ecto.Query
  require Logger

  def query_times_from_id(id) do
    case TimeManagerAPI.Repo.get(TimeManagerAPI.Workingtime, id) do
      nil -> {:error, "Working time with id #{id} not found"}
      query -> {:ok, extract_workingtime_from_query(query)}
    end
  end

  def query_times_for_edition(id) do
    case TimeManagerAPI.Repo.get(TimeManagerAPI.Workingtime, id) do
      nil -> {:error, "Working time with id #{id} not found"}
      query -> {:ok, query}
    end
  end

  def get_workingtimes_of_team(nil) do
    {:error, "Team not found"}
  end

  def query_times_from_id_and_times(userID, {:ok, start}, {:ok, myend}) when myend >= start do
    case TimeManagerAPI.Repo.get(TimeManagerAPI.User, userID) do
      nil ->
        {:error, "User with id #{userID} not found"}

      _ ->
        {:ok,
         TimeManagerAPI.Repo.all(
           from u in TimeManagerAPI.Workingtime,
             where: u.user_id == ^userID,
             where: u.start >= ^start,
             where: u.end <= ^myend,
             order_by: u.start,
             select: u
         )
         |> extract_workingtimes_from_query()}
    end
  end

  def query_times_from_id_and_times(_, {:ok, _}, {:ok, _}) do
    {:error, "The start time is after the end time"}
  end

  def query_times_from_id_and_times(_, {:error, msg}, {f, _}) when is_atom(f) do
    {:error, msg}
  end

  def query_times_from_id_and_times(_, {f, _}, {:error, msg}) when is_atom(f) do
    {:error, msg}
  end

  def insert_times_in_db(userID, {:ok, start}, {:ok, myend}) when myend >= start do
    insert_times_in_db(userID, start, myend)
  end

  def insert_times_in_db(_, {:ok, _}, {:ok, _}) do
    {:error, "The start time is after the end time"}
  end

  def insert_times_in_db(_, {:error, msg}, {f, _}) when is_atom(f) do
    {:error, msg}
  end

  def insert_times_in_db(_, {f, _}, {:error, msg}) when is_atom(f) do
    {:error, msg}
  end

  def insert_times_in_db(userID, start, myend) do
    change_set =
      %TimeManagerAPI.Workingtime{}
      |> Ecto.Changeset.cast(%{user_id: userID}, [:user_id])
      |> Ecto.Changeset.put_change(:start, start)
      |> Ecto.Changeset.put_change(:end, myend)

    # = TimeManagerAPI.Workingtime.changeset(%TimeManagerAPI.Workingtime{}, to_insert)

    if !Enum.empty?(change_set.errors) do
      {:error, "Error while inserting"}
    else
      case TimeManagerAPI.Repo.insert(change_set) do
        {:ok, res} -> {:ok, extract_workingtime_from_query(res)}
        {:error, res} -> {:error, res}
      end
    end
  end

  def update_time_in_db({:ok, target}, {:ok, start}, {:ok, myend}) when myend >= start do
    change_set = Ecto.Changeset.change(target, start: start, end: myend)

    if !Enum.empty?(change_set.errors) do
      {:error, "Error in changeset"}
    else
      case TimeManagerAPI.Repo.update(change_set) do
        {:ok, res} -> {:ok, extract_workingtime_from_query(res)}
        {:error, _} -> {:error, "Error when updating"}
      end
    end
  end

  def update_time_in_db({:ok, _}, {:ok, _}, {:ok, _}) do
    {:error, "The start time is after the end time"}
  end

  def update_time_in_db({:error, msg}, _, _) do
    {:error, msg}
  end

  def update_time_in_db(_, {:error, msg}, {f, _}) when is_atom(f) do
    {:error, msg}
  end

  def update_time_in_db(_, {f, _}, {:error, msg}) when is_atom(f) do
    {:error, msg}
  end

  def delete_time_in_db({:ok, target}) do
    id = target.id

    case TimeManagerAPI.Repo.delete(target) do
      {:ok, _} -> {:ok, %{message: "Workingtime with id #{id} as been deleted"}}
      {:error, _} -> {:error, "Error when deleting"}
    end
  end

  def delete_time_in_db({:error, msg}) do
    {:error, msg}
  end

  def show(conn, %{"userID" => userID, "start" => start, "end" => myend} = _) do
    start = create_datetime(start)
    myend = create_datetime(myend)

    query_times_from_id_and_times(userID, start, myend)
    |> render_json()
    |> send_response(conn)
  end

  def show(conn, %{"userID" => id} = _) do
    query_times_from_id(id)
    |> render_json()
    |> send_response(conn)
  end

  def show(conn, _) do
    render_json({:error, "Invalid arguments"})
    |> send_response(conn)
  end

  def create(conn, %{"userID" => userID, "start" => start, "end" => myend} = _) do
    start = create_datetime(start)
    myend = create_datetime(myend)

    insert_times_in_db(userID, start, myend)
    |> render_json()
    |> send_response(conn)
  end

  def create(conn, _) do
    render_json({:error, "Invalid arguments"})
    |> send_response(conn)
  end

  def update(conn, %{"id" => id, "start" => start, "end" => myend} = _) do
    start = create_datetime(start)
    myend = create_datetime(myend)

    query_times_for_edition(id)
    |> update_time_in_db(start, myend)
    |> render_json()
    |> send_response(conn)
  end

  def update(conn, _) do
    send_resp(conn, 400, "Missing argument")
  end

  def delete(conn, %{"id" => id} = _) do
    query_times_for_edition(id)
    |> delete_time_in_db()
    |> render_json()
    |> send_response(conn)
  end

  def delete(conn, _) do
    render_json({:error, "Invalid arguments"})
    |> send_response(conn)
  end

  def options(conn, _) do
    message =
      "Access-Control-Allow-Origin: *\r\n" <>
        "Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"

    send_resp(conn, 200, message)
  end
end
