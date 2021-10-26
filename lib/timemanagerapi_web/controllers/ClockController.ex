defmodule TimeManagerAPIWeb.ClocksController do
  use TimeManagerAPIWeb, :controller
  import Ecto.Query
  require Logger

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()

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
end
