defmodule PoeBuildPricer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PoeBuildPricerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PoeBuildPricer.PubSub},
      # Start the Endpoint (http/https)
      PoeBuildPricerWeb.Endpoint
      # Start a worker by calling: PoeBuildPricer.Worker.start_link(arg)
      # {PoeBuildPricer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PoeBuildPricer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PoeBuildPricerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
