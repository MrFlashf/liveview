defmodule Pento.Survey.Demographic do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pento.Accounts.User

  schema "demographics" do
    field :gender, :string
    field :year_of_birth, :integer
    belongs_to :user, User

    timestamps()
  end

  @fields ~w(gender year_of_birth user_id)a
  @genders [
    "male",
    "female",
    "other",
    "prefer not to say"
  ]

  @doc false
  def changeset(demographic, attrs) do
    demographic
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_inclusion(:gender, @genders)
    |> validate_inclusion(:year_of_birth, 1900..Date.utc_today().year)
    |> unique_constraint(:user_id)
  end
end
