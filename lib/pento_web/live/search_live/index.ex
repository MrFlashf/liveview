defmodule PentoWeb.SearchLive.Index do
  use PentoWeb, :live_view

  alias Pento.Catalog
  alias Pento.Catalog.Search

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:search, %Search{})
     |> assign_changeset()}
  end

  def handle_event(
        "validate",
        %{"search" => search_attrs},
        %{assigns: %{search: search}} = socket
      ) do
    changeset =
      search
      |> Catalog.change_search(search_attrs)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign_changeset(changeset)}
  end

  def update(%{search_product: product} = assigns, socket) do

    {:noreply, socket}
  end

  defp assign_changeset(%{assigns: %{search: search}} = socket) do
    assign(socket, :changeset, Catalog.change_search(search))
  end

  defp assign_changeset(socket, changeset) do
    assign(socket, :changeset, changeset)
  end
end
