defmodule Crimes.PageController do
  use Crimes.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
