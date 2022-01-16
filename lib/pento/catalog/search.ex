defmodule Pento.Catalog.Search do
  import Ecto.Changeset

  defstruct [:sku]

  @fields %{sku: :string}

  def changeset(struct, attrs) do
    {struct, @fields}
    |> cast(attrs, [:sku])
    |> validate_length(:sku, min: 7)
  end
end
