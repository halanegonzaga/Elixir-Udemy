defmodule AppWeb.AuthController do
  use AppWeb, :controller
  alias App.{Usuario, Repo}

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do

    # Estrutura usuário que será armazenada
    IO.inspect auth.info.email

    usuario = %{nome: auth.info.name, email: auth.info.email, token: auth.credentials.token, provider: provider}
    changeset = Usuario.changeset(%Usuario{}, usuario)
    logar conn, changeset
  end

  def logar(conn, changeset) do
    case insere_ou_busca(changeset) do
      {:ok, usuario} ->
          conn
          |> put_flash(:info, "Bem Vindo #{usuario.nome}")
          |> put_session(:user_id, usuario.id)
          |> redirect(to: Routes.tarefa_path(conn, :index))
      {:error, _} ->
          conn
          |> put_flash(:error, "Houve um problema na requisição")
          |> redirect(to: Routes.tarefa_path(conn, :index))
    end
  end

  def insere_ou_busca(changeset) do
    IO.inspect(changeset)
    case Repo.get_by(Usuario, email: changeset.changes.email) do
      nil -> Repo.insert changeset
      usuario -> {:ok, usuario}
    end
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.tarefa_path(conn, :index))
  end

end
