# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api_banking,
  ecto_repos: [ApiBanking.Repo]

# Configures the endpoint
config :api_banking, ApiBankingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "deBWT8ybdWnnilUqT2lWBMQqhrDTySieyX/gzK622m1mjAV0U4DkAxU9ng7fS6Y/",
  render_errors: [view: ApiBankingWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiBanking.PubSub,
  live_view: [signing_salt: "4k1FqojW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :api_banking, ApiBankingWeb.Auth.Guardian,
  issuer: "api_banking",
  secret_key: "1pfYar9bNIz+UIn/Y4ihkgEOLyIpDD2JSaTY4T68W4W9pHqQQckrcBhkucaD1mIV"

config :money,
  default_currency: :BRL

config :api_banking, ApiBankingWeb.Auth.Pipeline,
  module: ApiBankingWeb.Auth.Guardian,
  error_handler: ApiBankingWeb.Auth.ErrorHandler
