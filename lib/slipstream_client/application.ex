defmodule SlipstreamClient.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: SlipstreamClient.Worker.start_link(arg)
      # {SlipstreamClient.Worker, arg}
      {SlipstreamClient.Socket, [uri: "ws://localhost:4000/device_socket/websocket"]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SlipstreamClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
