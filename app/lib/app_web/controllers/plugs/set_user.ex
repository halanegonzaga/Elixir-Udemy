defmodule AppWeb.Plug.SetUser do
  use Phoenix.Controller

  import Plug.Conn

  alias AppWeb.Router.Helpers
  alias App.{Tarefa, Repo, Usuario}


  def init(_params) do
    
  end


  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(Usuario, user_id) ->
            assign conn, :user, user
      true ->
            assign conn, :user, nil
    end
  end

end
