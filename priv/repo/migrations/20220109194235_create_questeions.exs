defmodule Pento.Repo.Migrations.CreateQuesteions do
  use Ecto.Migration

  def change do
    create table(:questeions) do
      add :body, :string
      add :answer, :string
      add :vote_count, :integer

      timestamps()
    end
  end
end
