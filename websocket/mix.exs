defmodule Websocket.MixProject do
  use Mix.Project

  def project do
    [
      app: :websocket,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Websocket, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.4"}, # Criar Rotas
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"}, #JSON
      {:ex_doc, "~> 0.19.3"} #Documentação
    ]
  end
end
