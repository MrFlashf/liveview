defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_recipient()
     |> assign_changeset()}
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      Promo.change_recipient(recipient, recipient_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_changeset(socket, changeset)}
  end

  def handle_event(
        "save",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
        Process.sleep(1000)
    case Promo.send_promo(recipient, recipient_params) do
      :ok ->
        {:noreply,
         socket
         |> put_flash(:info, "Super jest dobrze chłopaki robią")}

      {:error, changeset} ->
        changeset = Map.put(changeset, :action, :safe)

        {:noreply, assign_changeset(socket, changeset)}
    end
  end

  defp assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end

  defp assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    assign(socket, :changeset, Promo.change_recipient(recipient))
  end

  defp assign_changeset(socket, changeset) do
    assign(socket, :changeset, changeset)
  end
end
