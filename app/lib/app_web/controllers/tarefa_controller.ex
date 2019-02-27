defmodule AppWeb.TarefaController do
  use AppWeb, :controller

  def new(conn, _params) do
    IO.inspect conn
    IO.puts "----------"
    IO.inspect _params
  end
end