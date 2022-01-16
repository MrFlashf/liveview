defmodule Pento.FAQ.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questeions" do
    field :answer, :string
    field :body, :string
    field :vote_count, :integer, default: 0

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:body, :answer, :vote_count])
    |> validate_required([:body, :answer])
  end

  def vote_changeset(question) do
    cast(question, %{vote_count: question.vote_count + 1}, [:vote_count])
  end
end
