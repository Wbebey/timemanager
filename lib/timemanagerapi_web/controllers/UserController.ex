defmodule TimeManagerAPIWeb.UsersController do
  use TimeManagerAPIWeb, :controller
  import Ecto.Query
  require Logger

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, %{"userID" => userID} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Users,
          where: u.id == ^userID,
          select: [:id, :username, :email],
          limit: 1
      )

    if(Enum.empty?(query)) do
      send_resp(conn, 404, "User not found")
    else
      myfirst = Enum.at(query, 0)

      json(conn, %{
        id: Map.fetch!(myfirst, :id),
        username: Map.fetch!(myfirst, :username),
        email: Map.fetch!(myfirst, :email)
      })
    end
  end

  def show(conn, %{"email" => email, "username" => username} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Users,
          where: u.email == ^email and u.username == ^username,
          select: [:id, :username, :email],
          limit: 1
      )

    if(Enum.empty?(query)) do
      send_resp(conn, 404, "User not found")
    else
      myfirst = Enum.at(query, 0)

      json(conn, %{
        id: Map.fetch!(myfirst, :id),
        username: Map.fetch!(myfirst, :username),
        email: Map.fetch!(myfirst, :email)
      })
    end
  end

  def show(conn, _params \\ :default) do
    send_resp(conn, 400, "Bad request: no id nor username/email combo")
  end

  def create(conn, %{"email" => email, "username" => username} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Users,
          where: u.email == ^email and u.username == ^username,
          select: u
      )

    if(!Enum.empty?(query)) do
      send_resp(conn, 400, "User has duplicate username or password")
    else
      toInsert = %{username: username, email: email}
      changeSet = TimeManagerAPI.Users.changeset(%TimeManagerAPI.Users{}, toInsert)

      if !Enum.empty?(changeSet.errors) do
        send_resp(conn, 400, "Invalid email format")
      else
        TimeManagerAPI.Repo.insert(changeSet)
        send_resp(conn, 200, "Created user " <> username)
      end
    end
  end

  def create(conn, _ \\ :default) do
    send_resp(conn, 400, "No username and/or no email")
  end

  def update(conn, %{"userID" => userID, "username" => username, "email" => email} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Users,
          where: u.id == ^userID,
          select: u
      )
      if(Enum.empty?(query)) do
        send_resp(conn, 404, "User not found")
      else
        changeSet =
          Enum.at(query, 0)
          |> Ecto.Changeset.change(username: username, email: email)
        if !Enum.empty?(changeSet.errors) do
          send_resp(conn, 400, "Invalid email format")
        else
          TimeManagerAPI.Repo.update(changeSet)
          send_resp(conn, 200, "Updated user " <> username)
        end
      end
  end

  def update(conn, _ \\ :default) do
    send_resp(conn, 400, "Missing argument")
  end

  def delete(conn, params) do
    send_resp(conn, 500, "Delete: " <> Kernel.inspect(params))
  end
end
