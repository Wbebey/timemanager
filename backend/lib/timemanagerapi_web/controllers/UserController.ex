defmodule TimeManagerAPIWeb.UsersController do
  use TimeManagerAPIWeb, :controller
  import TimeManagerAPIWeb.Shared
  import Ecto.Query
  require Logger

  def query_user_from_creds(username, email) do
    query = TimeManagerAPI.Repo.get_by(TimeManagerAPI.User, username: username, email: email)

    case query do
      nil -> {:error, "User #{username} not found"}
      query -> {:ok, extract_user_from_query(query)}
    end
  end

  def query_user_from_id(id) do
    query = TimeManagerAPI.Repo.get(TimeManagerAPI.User, id)

    case query do
      nil -> {:error, "User with id #{id} not found"}
      query -> {:ok, extract_user_from_query(query)}
    end
  end

  def query_user_for_edition(id) do
    query = TimeManagerAPI.Repo.get(TimeManagerAPI.User, id)

    case query do
      nil -> {:error, "User with id #{id} not found"}
      query -> {:ok, query}
    end
  end

  def query_user_for_duplicates(username, email) do
    query =
      from u in TimeManagerAPI.User,
        where:
          u.email == ^email or
            u.username ==
              ^username

    if TimeManagerAPI.Repo.exists?(query) do
      {:error, "User has a duplicate username or email"}
    else
      {:ok, {username, email}}
    end
  end

  def show(conn, %{"userID" => userID} = _) do
    query_user_from_id(userID)
    |> render_json()
    |> send_response(conn)
  end

  def show(conn, %{"email" => email, "username" => username} = _) do
    query_user_from_creds(username, email)
    |> render_json()
    |> send_response(conn)
  end

  def show(conn, _) do
    render_json({:error, "Bad request: no id nor username/email combo"})
    |> send_response(conn)
  end

  def insert_user_in_db({:ok, {username, email}}) do
    to_insert = %{username: username, email: email}
    change_set = TimeManagerAPI.User.changeset(%TimeManagerAPI.User{}, to_insert)

    if !Enum.empty?(change_set.errors) do
      {:error, "Invalid format for the email"}
    else
      case TimeManagerAPI.Repo.insert(change_set) do
        {:ok, res} -> {:ok, extract_user_from_query(res)}
        {:error, _} -> {:error, "Error when inserting"}
      end
    end
  end

  def insert_user_in_db({:error, message}) do
    {:error, message}
  end

  def create(conn, %{"email" => email, "username" => username} = _) do
    query_user_for_duplicates(username, email)
    |> insert_user_in_db()
    |> render_json()
    |> send_response(conn)
  end

  def create(conn, _) do
    render_json({:error, "Invalid arguments"})
    |> send_response(conn)
  end

  def update_user_in_db({:ok, user}, newUsername, newEmail) do
    change_set = Ecto.Changeset.change(user, username: newUsername, email: newEmail)

    if !Enum.empty?(change_set.errors) do
      {:error, "Invalid format for the email"}
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

  def update(conn, %{"userID" => userID, "username" => username, "email" => email} = _) do
    query_user_for_edition(userID)
    |> update_user_in_db(username, email)
    |> render_json()
    |> send_response(conn)
  end

  def update(conn, _) do
    render_json({:error, "Invalid arguments"})
    |> send_response(conn)
  end

  # using a changeset, update the field "role" of the user
  def promote_user(user, newRole) do
    change_set = Ecto.Changeset.change(user, role: newRole)

    if !Enum.empty?(change_set.errors) do
      {:error, "Invalid format for the role"}
    else
      case TimeManagerAPI.Repo.update(change_set) do
        {:ok, res} -> {:ok, extract_user_from_query(res)}
        {:error, _} -> {:error, "Error when updating"}
      end
    end
  end

  def promote(conn, %{"userID" => userID, "role" => "root"} = _) do
    user = TimeManagerAPI.Repo.get(TimeManagerAPI.User, userID)

    case user do
      nil -> {:error, "Error when getting user"}
      user -> promote_user(user, :root)
    end
    |> render_json()
    |> send_response(conn)
  end

  def promote(conn, %{"userID" => userID, "role" => "manager"} = _) do
    user = TimeManagerAPI.Repo.get(TimeManagerAPI.User, userID)

    case user do
      nil -> {:error, "Error when getting user"}
      user -> promote_user(user, :manager)
    end
    |> render_json()
    |> send_response(conn)
  end

  def promote(conn, %{"userID" => userID, "role" => "employe"} = _) do
    user = TimeManagerAPI.Repo.get(TimeManagerAPI.User, userID)

    case user do
      nil -> {:error, "Error when getting user"}
      user -> promote_user(user, :employe)
    end
    |> render_json()
    |> send_response(conn)
  end

  def promote(conn, %{"userID" => _, "role" => role}) do
    {:error, "Role #{role} is not valid."}
    |> render_json()
    |> send_response(conn)
  end

  def promote(conn, _) do
    {:error, "Invalid arguments"}
    |> render_json()
    |> send_response(conn)
  end

  def delete_user_in_db({:ok, user}) do
    username = user.username

    case TimeManagerAPI.Repo.delete(user) do
      {:ok, _} -> {:ok, %{message: "User #{username} as been deleted"}}
      {:error, _} -> {:error, "Error when deleting"}
    end
  end

  def delete_user_in_db({:error, message}) do
    {:error, message}
  end

  def delete(conn, %{"userID" => userID}) do
    query_user_for_edition(userID)
    |> delete_user_in_db()
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
