defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def index(conn, _params) do
    if conn.assigns.current_user do
      conn
      |> redirect(to: "/guess")
      |> halt()
    else
      render(conn, "index.html")
    end
  end
end
