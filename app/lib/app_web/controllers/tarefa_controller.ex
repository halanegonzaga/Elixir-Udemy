defmodule AppWeb.TarefaController do
  use AppWeb, :controller

  alias App.Tarefa

  def new(conn, _params) do
    changeset = Tarefa.changeset(%Tarefa{})

    render conn, "new.html", changeset: changeset, soma: Tarefa.soma(10, 2)
  end

  def create(conn, %{"tarefa" => tarefa}) do
    render conn, "tarefas.html", tarefa: tarefa
  end
end