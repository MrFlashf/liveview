defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    winning_number = generate_winning_number()

    {:ok, assign(socket, score: 0, message: "Guess a number", winning_number: winning_number)}
  end

  def handle_params(_params, _session, socket) do
    winning_number = generate_winning_number()

    {:noreply,
     assign(socket, score: 0, message: "Guess a number", winning_number: winning_number)}
  end

  def render(assigns) do
    ~L"""
      <h1>Your score: <%= @score %></h1>
      <h2>
        <%= @message %>
      </h2>
      <h2>
        <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
        <% end %>
      </h2>
      <%= live_patch "Refresh", to: Routes.live_path(@socket, PentoWeb.WrongLive) %>
    """
  end

  def handle_event(
        "guess",
        %{"number" => guessed_number},
        %{assigns: %{score: score, winning_number: winning_number}} = socket
      ) do
    if won?(String.to_integer(guessed_number), winning_number) do
      {:noreply,
       assign(socket,
         score: score + 1,
         message: "Congratulations, #{guessed_number} is CORRECT!",
         winning_number: generate_winning_number()
       )}
    else
      {:noreply, assign(socket, score: score - 1, message: "Sorry, #{guessed_number} is WRONG!")}
    end
  end

  def time do
    DateTime.utc_now() |> to_string()
  end

  defp won?(winning_number, winning_number), do: true
  defp won?(_guessed_number, _winning_number), do: false

  defp generate_winning_number, do: :rand.uniform(10)
end
