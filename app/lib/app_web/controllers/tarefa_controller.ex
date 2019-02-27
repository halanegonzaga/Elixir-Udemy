defmodule AppWeb.TarefaController do
  use AppWeb, :controller

  alias App.{Tarefa, Repo}

  def new(conn, _params) do
    changeset = Tarefa.changeset(%Tarefa{})

    render conn, "new.html", changeset: changeset, soma: Tarefa.soma(10, 2)
  end

  def create(conn, %{"tarefa" => tarefa}) do
    changeset = Tarefa.changeset(%Tarefa{}, tarefa)
    case Repo.insert changeset do
      {:ok, struct} ->
          conn
          |> put_flash(:info, "Tarefa incluida na sua lista #{struct.titulo}")
          |> redirect(to: Routes.tarefa_path(conn, :index)) #Redirecionamento
      {:error, changeset} -> render conn, "new.html", changeset: changeset
    end

    render conn, "index.html", tarefa: tarefa
  end

  def index(conn, _params) do
    render conn, "index.html", tarefas: Repo.all(Tarefa)
  end
end