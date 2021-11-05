defmodule TimeManagerAPI.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, unique: true
    field :username, :string, unique: true
    has_one :clock, TimeManagerAPI.Clock

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/.+@.+\..+/)
  end
end
