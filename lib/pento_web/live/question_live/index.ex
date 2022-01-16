defmodule PentoWeb.QuestionLive.Index do
  use PentoWeb, :live_view

  alias Pento.FAQ
  alias Pento.FAQ.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :questeions, list_questeions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Question")
    |> assign(:question, FAQ.get_question!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Question")
    |> assign(:question, %Question{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Questeions")
    |> assign(:question, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    question = FAQ.get_question!(id)
    {:ok, _} = FAQ.delete_question(question)

    {:noreply, assign(socket, :questeions, list_questeions())}
  end

  @impl true
  def handle_event("vote", %{"id" => question_id}, socket) do
    FAQ.vote(question_id)

    {:noreply, assign(socket, :questeions, list_questeions())}
  end

  defp list_questeions do
    FAQ.list_questeions()
  end
end
