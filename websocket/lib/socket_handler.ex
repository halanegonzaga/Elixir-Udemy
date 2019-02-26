defmodule Websocket.SocketHandler do
  @behaviour :cowboy_websocket

  @moduledoc """
    Gerenciar Conexões do Socket
  """


  @doc """
    Quando identificado abertura de conexão com o socket, recebe informações da sessão e manipula
    Numa analogia ao PHP, seria o evento onOpen
  """
  def init(request, _state) do
    state = %{registry_key: request.path}

#    IO.puts "Iniciou conexão"
#    IO.inspect(state);
#    IO.inspect(request);

    {:cowboy_websocket, request, state}
  end

  @doc """
    Quando houve o handshake com sessão, registra a mesma no canal identificado
  """
  def websocket_init(state) do
    Registry.Websocket
    |> Registry.register(state.registry_key, {})

#    IO.puts "Sessão foi registrada com sucesso WebSocket"
    
    {:ok, state}
  end

  @doc """
    Ao identificar nova mensagem de texto, binário, ping/pong
  """

  def websocket_handle({:text, json}, state) do
    payload = Jason.decode!(json)
    message = payload["data"]["message"]

#    IO.puts "Nova mensagem encaminhada: #{message} - sessão: " <> "Teste concatenando"
    
    Registry.Websocket
    |> Registry.dispatch(state.registry_key, fn(entries) -> 
      for {pid, _} <- entries do
        if pid != self() do
          Process.send(pid, message, [])
        end
      end
    end)

    {:reply, {:text, message}, state}
  end

  def websocket_info(info, state) do

    IO.inspect(info);
    IO.inspect(state);

    {:reply, {:text, info}, state}
  end

end