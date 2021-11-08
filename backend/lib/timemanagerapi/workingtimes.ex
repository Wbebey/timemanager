defmodule TimeManagerAPI.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :user, TimeManagerAPI.User
  end

  @doc false
  def changeset(workingtimes, attrs) do
    workingtimes
    |> cast(attrs, [:start, :end, :user])
    |> validate_required([:start, :end, :user])
  end
end
