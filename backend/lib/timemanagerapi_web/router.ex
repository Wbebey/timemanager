defmodule TimeManagerAPIWeb.Router do
  use TimeManagerAPIWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(CORSPlug)
  end

  scope "/api", TimeManagerAPIWeb do
    pipe_through(:api)

    scope "/users" do
      # create
      post("/", UsersController, :create)
      # read
      get("/", UsersController, :show)
      get("/:userID", UsersController, :show)
      # update
      put("/:userID", UsersController, :update)
      # delete
      delete("/:userID", UsersController, :delete)
    end

    scope "/workingtimes" do
      # create
      post("/:userID", WorkingTimesController, :create)
      # read
      # Get all of user
      get("/:userID", WorkingTimesController, :show)
      # Get specific timeframe
      get("/:id", WorkingTimesController, :show)
      # update
      put("/:id", WorkingTimesController, :update)
      # delete
      delete("/:id", WorkingTimesController, :delete)
    end

    scope "/clocks" do
      get("/:userID", ClocksController, :show)
      post("/:userID", ClocksController, :update)
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: TimeManagerAPIWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
