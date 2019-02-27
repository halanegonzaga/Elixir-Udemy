defmodule AppWeb.AuthController do
  use AppWeb, :controller

  plug Ueberauth

  def callback(conn, params) do
    IO.inspect conn
    IO.inspect params
  end
end
