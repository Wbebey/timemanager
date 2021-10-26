defmodule TimeManagerAPIWeb.WorkingTimesController do
  use TimeManagerAPIWeb, :controller
  import Ecto.Query
  require Logger

  def createDateTime(input) do
    split = String.split(input)
    left = String.split(split, '-')
    right = String.split(split, ':')
    mydate = Date.new!(Enum.at(left, 0), Enum.at(left, 1), Enum.at(left, 2))
    mytime = Date.new!(Enum.at(right, 0), Enum.at(right, 1), Enum.at(right,2))
    DateTime.new(mydate, mytime)
  end

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, %{"userID" => userID, "start" => start, "end" => myend} = _) do
    start = createDateTime(start)
    myend = createDateTime(myend)

    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.WorkingTimes,
          where: u.user == ^userID and u.start >= ^start and u.end <= ^myend,
          select: u,
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

  def show(conn, %{"id" => id} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.WorkingTimes,
          where: u.id == ^id,
          select: u,
          limit: 1
      )

    if(Enum.empty?(query)) do
      send_resp(conn, 404, "WorkingTimes not found")
    else
      myfirst = Enum.at(query, 0)

      json(conn,
        myfirst,
      )
    end
  end

  def show(conn, _params \\ :default) do
    send_resp(conn, 400, "Bad request: no id nor username/email combo")
  end

  def create(conn, %{"userID" => userID, "start" => start, "end" => end_} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Users,
          where: u.id == ^userID,
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
    send_resp(conn, 400, "Invalide argument")
  end

  def update(conn, %{"id" => id, "start" => start, "end" => myend} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.WorkingTimes,
          where: u.id == ^id,
          select: u
      )

    if(Enum.empty?(query)) do
      send_resp(conn, 404, "WorkingTimes not found")
    else
      changeSet =
        Enum.at(query, 0)
        |> Ecto.Changeset.change(start: start, end: myend)

      if !Enum.empty?(changeSet.errors) do
        send_resp(conn, 400, "Invalid start or/and end format")
      else
        TimeManagerAPI.Repo.update(changeSet)
        send_resp(conn, 200, "Updated WorkingTimes number " <> id)
      end
    end
  end

  def update(conn, _ \\ :default) do
    send_resp(conn, 400, "Missing argument")
  end

  def delete(conn, %{"id" => id} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.WorkingTimes,
          where: u.id == ^id,
          select: u
      )

    if(Enum.empty?(query)) do
      send_resp(conn, 404, "WorkingTimes not found")
    else
      workingTime = Map.fetch!(Enum.at(query, 0), :id)
      TimeManagerAPI.Repo.delete(Enum.at(query, 0))
      send_resp(conn, 200, "Deleted WorkingTimes number " <> workingTime)
    end
  end

  def delete(conn, _ \\ :default) do
    send_resp(conn, 400, "Missing id")
  end
end
