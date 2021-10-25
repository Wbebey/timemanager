defmodule TimeManagerAPIWeb.UsersController do
  use TimeManagerAPIWeb, :controller

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, %{"userID" => userID} = _) do
    send_resp(conn, 200, "Show: " <> userID)
  end

  def show(conn, %{"email" => email, "username" => username} = _) do
    send_resp(conn, 200, "Show: " <> email <> " " <> username)
  end

  def show(conn, _params \\ :default) do
    send_resp(conn, 400, "Bad request: no id nor username/password combo")
  end

  def create(conn, _params) do
    send_resp(conn, 500, "Create")
  end

  def update(conn, params) do
    send_resp(conn, 500, "Update: " <> Kernel.inspect(params))
  end

  def delete(conn, params) do
    send_resp(conn, 500, "Delete: " <> Kernel.inspect(params))
  end
end
