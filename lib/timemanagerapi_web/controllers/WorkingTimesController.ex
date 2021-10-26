defmodule TimeManagerAPIWeb.WorkingTimesController do
  use TimeManagerAPIWeb, :controller
  import Ecto.Query
  require Logger

  def applyThrice(arguments, function) do
    function.(Enum.at(arguments, 0), Enum.at(arguments, 1), Enum.at(arguments, 2))
  end

  def createDateTime(input) do
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

  def dateTimeToString(d) do
    "#{d.year}-#{d.month}-#{d.day} #{d.hour}:#{d.minute}:#{d.second}"
  end

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, %{"userID" => userID, "start" => start, "end" => myend} = _) do
    {startstatus, start} = createDateTime(start)
    {endstatus, myend} = createDateTime(myend)

    if Enum.any?([startstatus, endstatus], fn x -> x == :error end) do
      send_resp(conn, 404, "Invalid input")
    else
      query =
        TimeManagerAPI.Repo.all(
          from u in TimeManagerAPI.Workingtimes,
            where: u.user == ^userID and u.start >= ^start and u.end <= ^myend,
            select: u
        )

      if(Enum.empty?(query)) do
        send_resp(conn, 404, "No result found")
      else
        Logger.debug("ID" <> userID)

        myfiltered =
          query
          |> Enum.map(fn x ->
            %{
              start: Map.fetch!(x, :start) |> dateTimeToString,
              user: Map.fetch!(x, :user)
            }
            |> Map.put(:end, Map.fetch!(x, :end) |> dateTimeToString)
          end)

        json(conn, myfiltered)
      end
    end
  end

  def show(conn, %{"userID" => id} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Workingtimes,
          where: u.id == ^id,
          select: u,
          limit: 1
      )

    if(Enum.empty?(query)) do
      send_resp(conn, 404, "WorkingTimes not found")
    else
      myfirst = Enum.at(query, 0)

      func = fn x ->
        %{
          start: Map.fetch!(x, :start) |> dateTimeToString,
          user: Map.fetch!(x, :user)
        }
        |> Map.put(:end, Map.fetch!(x, :end) |> dateTimeToString)
      end

      result = func.(myfirst)

      json(
        conn,
        result
      )
    end
  end

  def show(conn, _params \\ :default) do
    send_resp(conn, 400, "Invalid arguments")
  end

  def create(conn, %{"userID" => userID, "start" => start, "end" => myend} = _) do
    {startstatus, start} = createDateTime(start)
    {endstatus, myend} = createDateTime(myend)

    if Enum.any?([startstatus, endstatus], fn x -> x == :error end) do
      send_resp(conn, 404, "Invalid input")
    else
      queryUser =
        TimeManagerAPI.Repo.all(
          from u in TimeManagerAPI.Users,
            where: u.id == ^userID,
            select: u
        )

      if(Enum.empty?(queryUser)) do
        send_resp(conn, 404, "User not found")
      else
        toInsert =
          %{
            start: start
          }
          |> Map.put(:end, myend)
          |> Map.put(:user, userID)

        changeSet =
          TimeManagerAPI.Workingtimes.changeset(%TimeManagerAPI.Workingtimes{}, toInsert)

        if !Enum.empty?(changeSet.errors) do
          send_resp(conn, 400, "Invalid email format")
        else
          TimeManagerAPI.Repo.insert(changeSet)
          send_resp(conn, 200, "Created task")
        end
      end
    end
  end

  def create(conn, _ \\ :default) do
    send_resp(conn, 400, "Invalide argument")
  end

  def update(conn, %{"id" => id, "start" => start, "end" => myend} = _) do
    Logger.debug("ID" <> id)
    {startstatus, start} = createDateTime(start)
    {endstatus, myend} = createDateTime(myend)

    if Enum.any?([startstatus, endstatus], fn x -> x == :error end) do
      send_resp(conn, 404, "Invalid input")
    else
      query =
        TimeManagerAPI.Repo.all(
          from u in TimeManagerAPI.Workingtimes,
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
  end

  def update(conn, _ \\ :default) do
    send_resp(conn, 400, "Missing argument")
  end

  def delete(conn, %{"id" => id} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Workingtimes,
          where: u.id == ^id,
          select: u
      )

    if(Enum.empty?(query)) do
      send_resp(conn, 404, "WorkingTimes not found")
    else
      TimeManagerAPI.Repo.delete(Enum.at(query, 0))
      send_resp(conn, 200, "Deleted WorkingTimes number " <> id)
    end
  end

  def delete(conn, _ \\ :default) do
    send_resp(conn, 400, "Missing id")
  end
end
