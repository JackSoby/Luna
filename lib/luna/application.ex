defmodule Luna.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LunaWeb.Telemetry,
      # Start the Ecto repository
      Luna.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Luna.PubSub},
      # Start Finch
      {Finch, name: Luna.Finch},
      # Start the Endpoint (http/https)
      LunaWeb.Endpoint
      # Start a worker by calling: Luna.Worker.start_link(arg)
      # {Luna.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Luna.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LunaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
