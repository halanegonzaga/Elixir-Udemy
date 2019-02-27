defmodule AppWeb.TarefaController do
  use AppWeb, :controller

  alias App.Tarefa

  def new(conn, _params) do
    changeset = Tarefa.changeset(%Tarefa{})

    render conn, "new.html", changeset: changeset, soma: Tarefa.soma(10,2)
  end
end