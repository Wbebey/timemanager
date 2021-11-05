defmodule TimeManagerAPI.Repo.Migrations.CreateTeamsTable do
  use Ecto.Migration

  def change do
    create table(:teams_associations) do
      add :team_id, references(:teams, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create unique_index(:teams_associations, [:team_id, :user_id])
  end
end
