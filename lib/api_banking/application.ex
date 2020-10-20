defmodule ApiBanking.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the Ecto repository
      ApiBanking.Repo,
      # Start the Telemetry supervisor
      ApiBankingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ApiBanking.PubSub},
      # Start the Endpoint (http/https)
      ApiBankingWeb.Endpoint,
      # Start a worker by calling: ApiBanking.Worker.start_link(arg)
      # {ApiBanking.Worker, arg}
      ApiBanking.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApiBanking.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ApiBankingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
