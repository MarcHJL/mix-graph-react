defmodule Backend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BackendWeb.Telemetry,
      # Start the Ecto repository
      Backend.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Backend.PubSub},
      # Start Finch
      {Finch, name: Backend.Finch},
      # Start the Endpoint (http/https)
      BackendWeb.Endpoint
      # Start a worker by calling: Backend.Worker.start_link(arg)
      # {Backend.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Backend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
