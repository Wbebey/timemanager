defmodule TimeManagerAPIWeb.ClocksController do
  use TimeManagerAPIWeb, :controller
  import TimeManagerAPIWeb.Shared
  import Ecto.Query
  require Logger

  def stop_clock(query, userID) do
    result_of_update =
      TimeManagerAPIWeb.WorkingTimesController.insert_times_in_db(
        TimeManagerAPI.Repo.get(TimeManagerAPI.User, userID).id,
        query.time,
        NaiveDateTime.local_now()
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

  def link_clock_to_user(clock, userID) do
    user =
      TimeManagerAPI.Repo.get!(TimeManagerAPI.User, userID) |> TimeManagerAPI.Repo.preload(:clock)

    change_set = Ecto.Changeset.change(user, clock: clock)

    case TimeManagerAPI.Repo.update(change_set) do
      {:ok, _} -> {:ok, extract_clock_from_query(clock) |> Map.replace(:user, userID)}
      {:error, _} -> {:error, "Error when updating"}
    end
  end

  def init_clock(userID) do
    res =
      %TimeManagerAPI.Clock{
        user_id: TimeManagerAPI.Repo.get(TimeManagerAPI.User, userID).id,
        status: true,
        time: NaiveDateTime.local_now()
      }
      |> TimeManagerAPI.Repo.insert()

    IO.inspect(res)

    case res do
      {:ok, newclock} ->
        link_clock_to_user(newclock, userID)

      {:error, _} ->
        {:error, "Error when creating a new clock"}
    end
  end

  def query_clock_for_edition(userID) do
    query_user = TimeManagerAPI.Repo.get_by(TimeManagerAPI.Clock, user_id: userID)

    case query_user do
      nil -> {:error, "No clock found"}
      query_user -> {:ok, query_user}
    end
  end

  def query_clock_from_user(user) do
    # Users - has_one :clock, TimeManagerAPI.Clock
    # Clocks - belongs_to :user, TimeManagerAPI.User
    query = TimeManagerAPI.Repo.get_by(TimeManagerAPI.Clock, user_id: user.id)

    IO.inspect(query)

    case query do
      nil -> {:error, "No clock found"}
      query -> {:ok, extract_clock_from_query(query)}
    end
  end

  def show(conn, %{"userID" => userID} = _) do
    case TimeManagerAPIWeb.UsersController.query_user_for_edition(userID) do
      {:ok, user} ->
        IO.inspect(user)
        query_clock_from_user(user)

      {:error, msg} ->
        {:error, msg}
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
          {:ok, clock} when clock.status == true -> stop_clock(clock, userID)
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
    message =
      "Access-Control-Allow-Origin: *\r\n" <>
        "Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"

    send_resp(conn, 200, message)
  end
end
