# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CcoBB4n9fSJ7Ag+BeeGN4IbysMESbbUd6yjXdRmkVh/WupbmkomdAO2k0VlvGPTz",
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Blog.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :blog, Blog.Repo,
  username: System.get_env("DATABASE_USER"),
  password: System.get_env("DATABASE_PASSWORD"),
  database: System.get_env("DATABASE_NAME"),
  hostname: System.get_env("DATABASE_HOST")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
config :cors_plug,
  origin: "*"

import_config "#{Mix.env()}.exs"
