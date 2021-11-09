defmodule TimeManagerAPI.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    # User infos
    field :email, :string, unique: true
    field :username, :string, unique: true
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    # Time management
    has_one :clock, TimeManagerAPI.Clock
    has_many :times, TimeManagerAPI.Workingtime

    # Role management
    field :role, Ecto.Enum, values: [:employe, :manager, :root], default: :employe
    many_to_many :teams, TimeManagerAPI.Team, join_through: "teams_associations"

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email, :role, :password, :password_confirmation])
    |> validate_required([:username, :email, :role, :password, :password_confirmation])
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end

end
