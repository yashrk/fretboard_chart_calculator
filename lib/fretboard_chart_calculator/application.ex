defmodule FretboardChartCalculator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FretboardChartCalculatorWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:fretboard_chart_calculator, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FretboardChartCalculator.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FretboardChartCalculator.Finch},
      # Start a worker by calling: FretboardChartCalculator.Worker.start_link(arg)
      # {FretboardChartCalculator.Worker, arg},
      # Start to serve requests, typically the last entry
      FretboardChartCalculatorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FretboardChartCalculator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FretboardChartCalculatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
