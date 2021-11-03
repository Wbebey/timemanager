defmodule TimeManagerAPIWeb.ManagerController do
  use TimeManagerAPIWeb, :controller
  import TimeManagerAPIWeb.Shared
  import Ecto.Query
  require Logger

  def query_all_direct_reports(id) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Users,
          where: u.manager == ^id,
          select: ^user_attributs()
      )

    if Enum.empty?(query) do
      {:ok, []}
    else
      {:ok, query |> Enum.map(&extract_user_from_query/1)}
    end
  end

  def update_manager_in_db({:ok, query}, manager) do
    change_set = Ecto.Changeset.change(query, manager: manager)

    if !Enum.empty?(change_set.errors) do
      {:error, "error in changeset"}
    else
      case TimeManagerAPI.Repo.update(change_set) do
        {:ok, res} -> {:ok, extract_user_from_query(res)}
        {:error, _} -> {:error, "Error when updating"}
      end
    end
  end

  def update_user_in_db({:error, message}, _, _) do
    {:error, message}
  end

  def show(conn, %{"userID" => userID} = _) do
    query_all_direct_reports(userID)
    |> render_json()
    |> send_response(conn)
  end

  def show(conn, _) do
    {:error, "No userID given"}
    |> render_json()
    |> send_response(conn)
  end

  def update(conn, %{"user" => user, "manager" => manager} = _) do
    manager = TimeManagerAPIWeb.UsersController.query_user_from_id(manager)

    case manager do
      {:ok, _} ->
        TimeManagerAPIWeb.UsersController.query_user_for_edition(user)
        |> update_manager_in_db(manager)

      {:error, msg} ->
        {:error, msg}
    end
    |> render_json()
    |> send_response(conn)
  end

  def update(conn, _) do
    {:error, "invalid arguments"}
    |> render_json()
    |> send_response(conn)
  end

  def delete(conn, %{"userID" => user} = _) do
    TimeManagerAPIWeb.UsersController.query_user_for_edition(user)
    |> update_manager_in_db(nil)
    |> render_json()
    |> send_response(conn)
  end

  def delete(conn, _) do
    {:error, "invalid arguments"}
    |> render_json()
    |> send_response(conn)
  end

  def options(conn, _) do
    message =
      "Access-Control-Allow-Origin: *\r\n" <>
        "Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"

    send_resp(conn, 200, message)
  end
end
