defmodule TimeManagerAPIWeb.Router do
  use TimeManagerAPIWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(CORSPlug, origin: ["*"])
  end

  scope "/api", TimeManagerAPIWeb do
    pipe_through(:api)

    scope "/users" do
      ## Object definitions: User
      # id: integer
      # name: string
      # email: string in format ~r/.+@.+\..+/
      # role: string, one of "root", "manager" or "employe"

      ## create
      # Create user
      # takes:
      #   name: string
      #   email: string in format ~r/.+@.+\..+/
      # returns: User object
      post("/", UsersController, :create)

      ## read
      # Get all users
      # returns: array of User objects
      get("/", UsersController, :show_all)

      # Get user by id
      # takes:
      #   userID: integer
      # returns: User object
      get("/:userID", UsersController, :show)

      # Get by role
      # takes:
      #   role: string, one of "root", "manager" or "employe"
      # returns: array of User object
      get("/management/:role", UsersController, :show_by_role)

      # Get teams
      # takes:
      #   userID: integer
      # returns: array of Team object
      get("/:userID/teams", UsersController, :show_teams)

      ## update
      # Update user
      # takes:
      #  userID: integer
      #  name: string
      #  email: string in format ~r/.+@.+\..+/
      # returns: User object
      put("/:userID", UsersController, :update)

      # Promote
      # takes:
      #  userID: integer
      #  role: string, one of "root", "manager" or "employe"
      # returns: User object
      put("/:userID/promote/:role", UsersController, :promote)

      ## delete
      # Delete user
      # takes:
      #   userID: integer
      # returns: a json object of format {"message": message}
      delete("/:userID", UsersController, :delete)

      ## options
      # for HTTP OPTIONS
      options("/", UsersController, :options)
      options("/:userID", UsersController, :options)
      options("/:userID/promote", UsersController, :options)
    end

    scope "/teams" do
      ## Object definitions: Team
      # id: integer
      # name: string
      #
      # Note: Users are not provided inline with the team.

      ## create
      # Create team
      # takes:
      #   name: string
      # returns: Team object
      post("/", TeamsController, :create)

      ## read
      # Get a team
      # takes:
      #   teamID: integer
      # returns: Team object
      get("/:teamID", TeamsController, :show)

      # Get all teams
      # returns: array of Team objects
      get("/", TeamsController, :show)

      # Get users in team
      # takes:
      #   teamID: integer
      # returns: array of User objects
      get("/:teamID/users", TeamsController, :get_users)

      # Get times in team
      # takes:
      #   teamID: integer
      # returns: array of Time objects
      get("/:teamID/times", TeamsController, :get_times)

      ## update
      # Rename team
      # takes:
      #   teamID: integer
      #   name: string
      # returns: Team object
      put("/:teamID", TeamsController, :update)

      # Add user to team
      # takes:
      #   teamID: integer
      #   userID: integer
      # returns: Team object
      post("/:teamID/users/:userID", TeamsController, :add_user)

      ## delete
      # Delete team
      # takes:
      #   teamID: integer
      # returns: a json object of format {"message": message}
      delete("/:teamID", TeamsController, :delete)

      # Remove user from team
      # takes:
      #   teamID: integer
      #   userID: integer
      # returns: Team object
      delete("/:teamID/users/:userID", TeamsController, :remove_user)

      ## options
      # for HTTP OPTIONS
      options("/", TeamsController, :options)
      options("/:teamID", TeamsController, :options)
      options("/:teamID/users/", TeamsController, :options)
    end

    scope "/workingtimes" do
      ## Object definition: WorkingTime
      # id: integer
      # user: integer
      # start: string in format "YYYY-MM-DD HH:MM:SS"
      # end: string in format "YYYY-MM-DD HH:MM:SS"

      ## create
      # create working time
      #
      # takes:
      #   userID: userID
      #   start: start time in format "YYYY-MM-DD HH:MM:SS"
      #   end: end time in format "YYYY-MM-DD HH:MM:SS"*
      #
      # returns: working time object
      post("/:userID", WorkingTimesController, :create)

      ## read
      # Get all working times of user
      #
      # takes:
      #   userID: userID
      #
      # returns: array of working time objects
      get("/:userID", WorkingTimesController, :show)

      # Get specific timeframe
      # takes:
      #   id: WorkingTime id
      # returns: working time object
      get("/management/:id", WorkingTimesController, :show_specific_time)

      ## update
      # Update working time
      # takes:
      #  id: WorkingTime id
      #  start: start time in format "YYYY-MM-DD HH:MM:SS"
      #  end: end time in format "YYYY-MM-DD HH:MM:SS"
      # returns: updated working time object
      put("/management/:id", WorkingTimesController, :update)

      ## delete
      # Delete working time
      # takes:
      #  id: WorkingTime id
      # returns: a json object of format {"message": message}
      delete("/management/:id", WorkingTimesController, :delete)

      ## options
      # for HTTP OPTIONS
      options("/", WorkingTimesController, :options)
      options("/:userID", WorkingTimesController, :options)
    end

    scope "/clocks" do
      ## Object definition: Clock
      # id: integer
      # user: integer
      # time: string in format "YYYY-MM-DD HH:MM:SS"
      # status: boolean

      ## read
      # Get the clock of a user
      # takes:
      #   userID: userID
      # returns: clock object or error on non-existing clock
      get("/:userID", ClocksController, :show)

      ## create/update
      # Create/update the clock of a user
      # takes:
      #   userID: userID
      # returns; clock object
      post("/:userID", ClocksController, :update)

      ## NO DELETE ##

      ## options
      # for HTTP OPTIONS
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
