defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(recipient, attrs) do
    with %{valid?: true} <- Recipient.changeset(recipient, attrs) do
      :ok
    else
      changeset ->
        {:error, changeset}
    end
  end
end
