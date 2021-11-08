defmodule TimeManagerAPI.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    # User infos
    field :email, :string, unique: true
    field :username, :string, unique: true

    # Time management
    has_one :clock, TimeManagerAPI.Clock
    has_many :times, TimeManagerAPI.Workingtime

    # Role management
    field :role, Ecto.Enum, values: [:employe, :manager, :root], default: :employe
    many_to_many :teams, TimeManagerAPI.Team, join_through: "teams_associations"
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email, :role])
    |> validate_required([:username, :email, :role])
    |> validate_format(:email, ~r/.+@.+\..+/)
  end
end
