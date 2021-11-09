defmodule TimeManagerAPI.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    # User infos
    field :email, :string, unique: true
    field :username, :string, unique: true
    field :password, :string
    field :password_hash, :string, virtual: true

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
    |> cast(attrs, [:username, :email, :role, :password_hash])
    |> validate_required([:username, :email, :role, :password_hash])
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> validate_length(:password_hash, min: 2)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password_hash: pass}}
        ->
          put_change(changeset, :password, Bcrypt.hash_pwd_salt(pass))
      _ ->
          changeset
    end
  end

end
