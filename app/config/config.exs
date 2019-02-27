# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app,
       ecto_repos: [App.Repo]

# Configures the endpoint
config :app,
       AppWeb.Endpoint,
       url: [
         host: "localhost"
       ],
       secret_key_base: "Q0uFlJFmdKaDL/bvgennSgRmphja5kR5j/8VZHVrVCTDSMZfRonO1rMUezRljXfw",
       render_errors: [
         view: AppWeb.ErrorView,
         accepts: ~w(html json)
       ],
       pubsub: [
         name: App.PubSub,
         adapter: Phoenix.PubSub.PG2
       ]

# Configures Elixir's Logger
config :logger,
       :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

#Configuração
config :ueberauth,
       Ueberauth,
       providers: [
         github: {Ueberauth.Strategy.Github, [default_scope: "user,public_repo,notifications"]}
       ]

config :ueberauth,
       Ueberauth.Strategy.Github.OAuth,
       client_id: "1ed3392ba32379caf2dd",
       client_secret: "c5a0fae60433b08ebe3cd7c6735fadc1f88314f5"