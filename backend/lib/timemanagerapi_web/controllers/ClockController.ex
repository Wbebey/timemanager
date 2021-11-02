defmodule TimeManagerAPIWeb.ClocksController do
  use TimeManagerAPIWeb, :controller
  import TimeManagerAPIWeb.Shared
  import Ecto.Query
  require Logger

  def stop_clock(query) do
    clockin = query.time

    result_of_update =
      TimeManagerAPIWeb.WorkingTimesController.insert_times_in_db(
        query.user,
        {:ok, clockin},
        {:ok, NaiveDateTime.local_now()}
      )

    case result_of_update do
      {:ok, _} -> change_clock(query, false)
      {:error, msg} -> {:error, msg}
    end
  end

  def change_clock(query, status) do
    change_set = Ecto.Changeset.change(query, status: status, time: NaiveDateTime.local_now())

    if !Enum.empty?(change_set.errors) do
      {:error, "Error in changeset"}
    else
      case TimeManagerAPI.Repo.update(change_set) do
        {:ok, res} -> {:ok, extract_clock_from_query(res)}
        {:error, _} -> {:error, "Error when updating"}
      end
    end
  end

  def start_clock(query) do
    change_clock(query, true)
  end

  def init_clock(userID) do
    res =
      TimeManagerAPI.Clocks.changeset(%TimeManagerAPI.Clocks{}, %{
        user: userID,
        time: NaiveDateTime.local_now(),
        status: true
      })
      |> TimeManagerAPI.Repo.insert()

    case res do
      {:ok, newclock} -> {:ok, extract_clock_from_query(newclock)}
      {:error, _} -> {:error, "Error when creating a new clock"}
    end
  end

  def query_clock_for_edition(userID) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Clocks,
          where: u.user == ^userID,
          select: [:id, :user, :status, :time],
          limit: 1
      )

    if Enum.empty?(query) do
      {:error, "Clock with for user with ID #{userID} not found"}
    else
      {:ok, query |> Enum.at(0)}
    end
  end

  def query_clock_from_id(userID) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Clocks,
          where: u.user == ^userID,
          select: [:id, :user, :status, :time],
          limit: 1
      )

    if Enum.empty?(query) do
      {:error, "Clock for user with id #{userID} not found"}
    else
      {:ok, extract_clock_from_query(query)}
    end
  end

  def show(conn, %{"userID" => userID} = _) do
    case TimeManagerAPIWeb.UsersController.query_user_from_id(userID) do
      {:ok, _} -> query_clock_from_id(userID)
      {:error, msg} -> {:error, msg}
    end
    |> render_json()
    |> send_response(conn)
  end

  def show(conn, _) do
    render_json({:error, "Invalid arguments"})
    |> send_response(conn)
  end

  def update(conn, %{"userID" => userID} = _) do
    case TimeManagerAPIWeb.UsersController.query_user_from_id(userID) do
      {:ok, _} ->
        case query_clock_for_edition(userID) do
          {:ok, clock} when clock.status == true -> stop_clock(clock)
          {:ok, clock} -> start_clock(clock)
          {:error, _} -> init_clock(userID)
        end

      {:error, msg} ->
        {:error, msg}
    end
    |> render_json()
    |> send_response(conn)
  end

  def update(conn, _) do
    render_json({:error, "Invalid arguments"})
    |> send_response(conn)
  end

  def options(conn, _) do
    send_resp(conn, 200, "Access-Control-Allow-Origin: *")
  end
end
