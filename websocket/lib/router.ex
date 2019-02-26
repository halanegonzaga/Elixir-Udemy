defmodule Websocket.Router do
    use Plug.Router
    require EEx

    @moduledoc """
      Gerenciamento das rotas da aplicação
      Todas rotas podem ter tipo GET,POST, PATCH
    """

    plug Plug.Static,
         at: "/",
         from: :websocket

    plug :match

    plug Plug.Parsers,
        parsers: [:json],
        pass: ["application/json"],
        json_decoder: Jason

    plug :dispatch
  
    EEx.function_from_file(:defp, :application_html, "lib/application.html.eex", [])

    # Teste de Chat

    get "/pilot" do
        send_resp(conn, 200, application_html())
    end

    # Página de Teste

    get "/test" do
        send_resp(conn, 200, "Hello World")
    end

    # Não Localizado

    match _ do
        send_resp(conn, 404, "404 - Not Found")
    end
end