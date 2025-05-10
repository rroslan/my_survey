defmodule MySurvey.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MySurveyWeb.Telemetry,
      MySurvey.Repo,
      {DNSCluster, query: Application.get_env(:my_survey, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MySurvey.PubSub},
      # Start a worker by calling: MySurvey.Worker.start_link(arg)
      # {MySurvey.Worker, arg},
      # Start to serve requests, typically the last entry
      MySurveyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MySurvey.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MySurveyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
