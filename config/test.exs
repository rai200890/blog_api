use Mix.Config

# Configure your database
config :blog, Blog.Repo,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :blog, BlogWeb.Endpoint,
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
