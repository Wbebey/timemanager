defmodule TimeManagerAPIWeb.ClocksController do
  use TimeManagerAPIWeb, :controller
  import Ecto.Query
  require Logger

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()

  def saveClockToWorkingTimes(infos) do
    result = infos |> Enum.at(0)

    toInsert =
      %{
        start: Map.get(result, :time)
      }
      |> Map.put(:end, NaiveDateTime.local_now())
      |> Map.put(:user, Map.get(result, :user))

    {insertResult, l} =
      TimeManagerAPI.Workingtimes.changeset(%TimeManagerAPI.Workingtimes{}, toInsert)
      |> TimeManagerAPI.Repo.insert()

    {updateResult, r} =
      result
      |> Ecto.Changeset.change(time: NaiveDateTime.local_now(), status: false)
      |> TimeManagerAPI.Repo.update()

    Logger.debug(l)
    Logger.debug(r)

    if insertResult == :ok and updateResult == :ok do
      {:ok, "OK - Clocked out"}
    else
      {:error, "A DB process failed, but it might have side-effected"}
    end
  end

  def startClock(query) do
    result =
      Enum.at(query, 0)
      |> Ecto.Changeset.change(time: NaiveDateTime.local_now(), status: true)
      |> TimeManagerAPI.Repo.update()

    case result do
      {:ok, _} -> {:ok, "OK - Clocked in"}
      {:error, _} -> {:error, "Error in DB"}
    end
  end

  def initClock(userID) do
    TimeManagerAPI.Clocks.changeset(%TimeManagerAPI.Clocks{}, %{
      user: userID,
      time: NaiveDateTime.local_now()
    })
    |> TimeManagerAPI.Repo.insert()
  end

  def show(conn, %{"userID" => userID} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Clocks,
          where: u.user == ^userID,
          select: u,
          limit: 1
      )

    if(Enum.empty?(query)) do
      send_resp(conn, 404, "No clock found for this user")
    else
      myfirst = Enum.at(query, 0)

      json(conn, %{
        time:
          Map.fetch!(myfirst, :time)
          |> TimeManagerAPIWeb.WorkingTimesController.dateTimeToString(),
        user: Map.fetch!(myfirst, :user),
        status: Map.fetch!(myfirst, :status)
      })
    end
  end

  def update(conn, %{"userID" => userID} = _) do
    query =
      TimeManagerAPI.Repo.all(
        from u in TimeManagerAPI.Clocks,
          where: u.user == ^userID,
          select: u,
          limit: 1
      )

    if(Enum.empty?(query)) do
      initClock(userID)
      send_resp(conn, 200, "First clock initialised")
    else
      myfirst = query |> Enum.at(0)

      {return, message} =
        case myfirst |> Map.get(:status) do
          true -> saveClockToWorkingTimes(query)
          false -> startClock(query)
        end

      code =
        case return do
          :ok -> 200
          :error -> 400
        end

      send_resp(conn, code, message)
    end
  end
end
