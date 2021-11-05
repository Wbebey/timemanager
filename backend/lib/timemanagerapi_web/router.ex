defmodule TimeManagerAPIWeb.Router do
  use TimeManagerAPIWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(CORSPlug, origin: ["*"])
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
      # promote
      put("/:userID/promote/:role", UsersController, :promote)
      # delete
      delete("/:userID", UsersController, :delete)
      options("/", UsersController, :options)
      options("/:userID", UsersController, :options)
      options("/:userID/promote", UsersController, :options)
    end

    scope "/teams" do
      # create
      post("/", TeamsController, :create)
      # read
      get("/:teamID", TeamsController, :show)
      get("/", TeamsController, :show)
      # rename team
      put("/:teamID", TeamsController, :update)
      # delete team
      delete("/:teamID", TeamsController, :delete)
      # add user to team
      post("/:teamID/users/:userID", TeamsController, :add_user)
      # get users in team
      get("/:teamID/users", TeamsController, :get_users)
      # get times in team
      get("/:teamID/times", TeamsController, :get_times)
      # remove user from team
      delete("/:teamID/users/:userID", TeamsController, :remove_user)
      options("/", TeamsController, :options)
      options("/:teamID", TeamsController, :options)
      options("/:teamID/users/", TeamsController, :options)
    end

    scope "/workingtimes" do
      # create
      post("/:userID", WorkingTimesController, :create)
      # read
      # Get all of user
      get("/:userID", WorkingTimesController, :show)
      # Get specific timeframe
      # This road is commented out because it is not used, as it is handled by the one above
      # It's mostly to prevent a warning on compilation
      # The relevant business logic is handled in the controller anyway
      # get("/:id", WorkingTimesController, :show)
      # update
      put("/:id", WorkingTimesController, :update)
      # delete
      delete("/:id", WorkingTimesController, :delete)
      options("/", WorkingTimesController, :options)
      options("/:userID", WorkingTimesController, :options)
    end

    scope "/clocks" do
      get("/:userID", ClocksController, :show)
      post("/:userID", ClocksController, :update)
      options("/", ClocksController, :options)
      options("/:userID", ClocksController, :options)
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
