defmodule TimeManagerAPI.Repo.Migrations.AddPasswordField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password_hash, :string
      add :password, :string, virtual: true
      add :password_confirmation, :string, virtual: true
    end
  end
end
