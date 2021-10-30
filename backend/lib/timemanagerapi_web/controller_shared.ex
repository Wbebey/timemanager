defmodule TimeManagerAPIWeb.Shared do
  import Plug.Conn

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

  def extract_user_from_query([head | tail]) when tail == [] do
    %{
      id: head.id,
      username: head.username,
      email: head.email
    }
  end

  def extract_user_from_query(head) do
    %{
      id: head.id,
      username: head.username,
      email: head.email
    }
  end

  def extract_clock_from_query([head | tail]) when tail == [] do
    %{
      id: head.id,
      status: head.status,
      user: head.user,
      time: head.time |> datetime_to_string()
    }
  end

  def extract_clock_from_query(head) do
    %{
      id: head.id,
      status: head.status,
      user: head.user,
      time: head.time |> datetime_to_string()
    }
  end

  def extract_workingtime_from_query([head | tail]) when tail == [] do
    %{
      id: head.id,
      start: head.start |> datetime_to_string(),
      end: head.end |> datetime_to_string(),
      user: head.user
    }
  end

  def extract_workingtime_from_query(head) do
    %{
      id: head.id,
      start: head.start |> datetime_to_string(),
      end: head.end |> datetime_to_string(),
      user: head.user
    }
  end

  def extract_workingtimes_from_query(elems) do
    elems
    |> Enum.map(&extract_workingtime_from_query/1)
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
