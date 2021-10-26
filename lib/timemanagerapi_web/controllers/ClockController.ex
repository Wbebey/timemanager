defmodule TimeManagerAPIWeb.ClocksController do
  use TimeManagerAPIWeb, :controller
  import Ecto.Query
  require Logger

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()

  def show(conn, %{"userID" => userID} = _) do
      query =
          TimeManagerAPI.Repo.all(
              from u in TimeManagerAPI.Users,
                  where: u.id == ^userID,
                  select: u,
                  limit: 1
          )
      if(Enum.empty?(query)) do
          send_resp(conn, 400, "User not found in database")
      else
          myfirst = Enum.at(query, 0)
          json(conn, %{
              id: Map.fetch!(myfirst, :username),
              username: Map.fetch!(myfirst, :username)
          })
      end
  end
end
