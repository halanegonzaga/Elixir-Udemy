defmodule Websocket do
  use Application

  @moduledoc """
    Inicializar configurações do socket
  """

  @doc """
    Definir supervisor
  """
  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Websocket.Router,
        options: [
          dispatch: dispatch(),
          port: 3000
        ]
      ),

      Registry.child_spec(
        keys: :duplicate,
        name: Registry.Websocket
      )
    ]

    opts = [strategy: :one_for_one, name: Websocket.Application]
    Supervisor.start_link(children, opts)
  end

  @doc """
    Controle das Rotas / WebSocket
  """

  defp dispatch do
    [
      {:_,
        [
          {"/ws/[...]", Websocket.SocketHandler, []},
          {:_, Plug.Cowboy.Handler, {Websocket.Router, []}}
        ]
      }
    ]
  end
end
