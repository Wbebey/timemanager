defmodule TimeManagerAPIWeb.TeamsController do
  use TimeManagerAPIWeb, :controller
  import TimeManagerAPIWeb.Shared
  import Ecto.Query
  require Logger

  def create_team(name) do
    newTeam =
      TimeManagerAPI.Repo.insert(%TimeManagerAPI.Team{
        name: name
      })

    case newTeam do
      {:ok, newTeam} -> {:ok, extract_team_from_query(newTeam)}
      {:error, _} -> {:error, "Error when inserting"}
    end
  end

  def get_team(teamID) do
    value = TimeManagerAPI.Repo.get(TimeManagerAPI.Team, teamID)

    case value do
      nil -> {:error, "Error when getting team"}
      team -> {:ok, extract_team_from_query(team)}
    end
  end

  def get_teams() do
    {:ok, TimeManagerAPI.Repo.all(TimeManagerAPI.Team) |> Enum.map(&extract_team_from_query/1)}
  end

  # Using a changeset, rename the team with a given name
  def rename_team(team, name) do
    changeset = Ecto.Changeset.change(team, name: name)

    case TimeManagerAPI.Repo.update(changeset) do
      {:ok, newTeam} -> {:ok, extract_team_from_query(newTeam)}
      {:error, _} -> {:error, "Error when renaming team"}
    end
  end

  # Delete a given team
  # returns either a {:ok, message} or a {:error, message}
  def delete_team(team) do
    case TimeManagerAPI.Repo.delete(team) do
      {:ok, _} -> {:ok, "Team #{team.name} deleted"}
      {:error, _} -> {:error, "Error when deleting team"}
    end
  end

  def get_users_of_team(team) do
    team = team |> TimeManagerAPI.Repo.preload(:users)
    {:ok, team.users |> Enum.map(&extract_user_from_query/1)}
  end

  def get_workingtimes_of_team(team) do
    # team = team |> TimeManagerAPI.Repo.preload(:users)
    # users = team.users |> TimeManagerAPI.Repo.preload(:times)

    try do
      times =
        team
        |> get_relation(:users)
        |> get_relation(:times)
        |> Enum.map(&extract_workingtimes_from_query/1)
        |> List.flatten()

      {:ok, times}
    rescue
      _ -> {:error, "Error while fetching Team #{team.name}"}
    end
  end

  def remove_user_from_team(team, user) do
    TimeManagerAPI.Repo.delete_all(
      from t in "teams_associations",
        where: t.team_id == ^team.id,
        where: t.user_id == ^user.id
    )

    {:ok, "Removed user #{user.id} from team #{team.id}"}
  end

  def create(conn, %{"name" => name} = _) do
    create_team(name)
    |> render_json()
    |> send_response(conn)
  end

  def create(conn, _) do
    {:error, "Invalid arguments"}
    |> render_json()
    |> send_response(conn)
  end

  def show(conn, %{"teamID" => teamID} = _) do
    get_team(teamID)
    |> render_json()
    |> send_response(conn)
  end

  def show(conn, _) do
    get_teams()
    |> render_json()
    |> send_response(conn)
  end

  def update(conn, %{"teamID" => teamID, "name" => name} = _) do
    team = TimeManagerAPI.Repo.get(TimeManagerAPI.Team, teamID)

    case team do
      nil -> {:error, "Error when getting team"}
      team -> rename_team(team, name)
    end
    |> render_json()
    |> send_response(conn)
  end

  def update(conn, _) do
    {:error, "Invalid arguments"}
    |> render_json()
    |> send_response(conn)
  end

  def delete(conn, %{"teamID" => teamID} = _) do
    team = TimeManagerAPI.Repo.get(TimeManagerAPI.Team, teamID)

    case team do
      nil -> {:error, "Error when getting team"}
      team -> delete_team(team)
    end
    |> render_json()
    |> send_response(conn)
  end

  def delete(conn, _) do
    {:error, "Invalid arguments"}
    |> render_json()
    |> send_response(conn)
  end

  def add_user(conn, %{"teamID" => teamID, "userID" => userID} = _) do
    team = TimeManagerAPI.Repo.get(TimeManagerAPI.Team, teamID)
    user = TimeManagerAPI.Repo.get(TimeManagerAPI.User, userID)

    case {team, user} do
      {nil, _} -> {:error, "Error when getting team"}
      {_, nil} -> {:error, "Error when getting user"}
      {team, user} -> add_user_to_team(team, user)
    end
    |> render_json()
    |> send_response(conn)
  end

  def add_user(conn, _) do
    {:error, "Invalid arguments"}
    |> render_json()
    |> send_response(conn)
  end

  def get_users(conn, %{"teamID" => teamID} = _) do
    team = TimeManagerAPI.Repo.get(TimeManagerAPI.Team, teamID)

    case team do
      nil -> {:error, "Error when getting team"}
      team -> get_users_of_team(team)
    end
    |> render_json()
    |> send_response(conn)
  end

  def get_users(conn, _) do
    {:error, "Invalid arguments"}
    |> render_json()
    |> send_response(conn)
  end

  def get_times(conn, %{"teamID" => teamID} = _) do
    TimeManagerAPI.Repo.get(TimeManagerAPI.Team, teamID)
    |> get_workingtimes_of_team()
    |> render_json()
    |> send_response(conn)
  end

  def remove_user(conn, %{"teamID" => teamID, "userID" => userID} = _) do
    team = TimeManagerAPI.Repo.get(TimeManagerAPI.Team, teamID)
    user = TimeManagerAPI.Repo.get(TimeManagerAPI.User, userID)

    case {team, user} do
      {nil, _} -> {:error, "Error when getting team"}
      {_, nil} -> {:error, "Error when getting user"}
      {team, user} -> remove_user_from_team(team, user)
    end
    |> render_json()
    |> send_response(conn)
  end

  def options(conn, _) do
    message =
      "Access-Control-Allow-Origin: *\r\n" <>
        "Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"

    send_resp(conn, 200, message)
  end
end
