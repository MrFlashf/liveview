defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pento.Survey.Rating

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string

    has_many :ratings, Rating

    timestamps()
  end

  @fields ~w(name description unit_price sku image_upload)a

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, @fields)
    |> validate_required(@fields -- [:image_upload])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end

  def decrease_price_changeset(product, unit_price) do
    product
    |> cast(%{unit_price: unit_price}, [:unit_price])
    |> validate_number(:unit_price, less_than: product.unit_price)
  end
end
