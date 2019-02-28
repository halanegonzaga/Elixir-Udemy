defmodule AppWeb.TarefaController do
  use AppWeb, :controller

  alias App.{Tarefa, Repo}

  plug AppWeb.Plug.RequireAuth when action in [:create, :update, :edit, :new]

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
        |> redirect(to: Routes.tarefa_path(conn, :index))
      #Redirecionamento
      {:error, changeset} -> render conn, "new.html", changeset: changeset
    end

    render conn, "index.html", tarefa: tarefa
  end

  def index(conn, params) do
    IO.inspect conn.assigns.user
    render conn, "index.html", tarefas: Repo.all(Tarefa)
  end

  def edit(conn, %{"id" => tarefa_id}) do
    tarefa = Repo.get(Tarefa, tarefa_id) # Buscando Tarefa no Banco
    changeset = Tarefa.changeset(tarefa)

    render conn, "edit.html", changeset: changeset, tarefa: tarefa
  end

  def update(conn, %{"tarefa" => tarefa, "id" => id}) do
    tarefa_alterar = Repo.get(Tarefa, id)
    changeset = Tarefa.changeset(tarefa_alterar, tarefa)

    case Repo.update(changeset) do
      {:ok, struct} ->
        conn
        |> put_flash(:info, "Tarefa atualizada na sua lista #{struct.titulo}")
        |> redirect(to: Routes.tarefa_path(conn, :index))
      {:error, changeset} -> render conn, "edit.html", changeset: changeset
    end

    render conn, "index.html", changeset: changeset, tarefa: tarefa
  end


  def delete(conn, %{"id" => id}) do
    Repo.get(Tarefa, id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "Tarefa deletada com sucesso")
    |> redirect(to: Routes.tarefa_path(conn, :index))
  end
end