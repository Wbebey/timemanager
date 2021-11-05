defmodule(TimeManagerAPI.Team) do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string, null: false, unique: true
    many_to_many :users, TimeManagerAPI.User, join_through: "teams_associations"
  end

  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :users_ids])
    |> validate_required([:name])
  end
end
