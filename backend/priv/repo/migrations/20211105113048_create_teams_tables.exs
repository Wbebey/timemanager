defmodule TimeManagerAPI.Repo.Migrations.CreateTeamsTable do
  use Ecto.Migration

  def change do
    create table(:teams_associations) do
      add :team_id, references(:teams)
      add :user_id, references(:users)
    end

    create unique_index(:teams_associations, [:team_id, :user_id])
  end
end
