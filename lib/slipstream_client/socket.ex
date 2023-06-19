defmodule SlipstreamClient.Socket do
  @moduledoc false

  use Slipstream
  require Logger

  @topic "device:general"

  def start_link(config) do
    GenServer.start_link(__MODULE__, config, name: __MODULE__)
  end


  @impl Slipstream
  def init(config) do
    opts = [
      uri: config[:url],
    ]

    socket = connect!(config)

    {:ok, socket}
  end

  @impl Slipstream
  def handle_connect(socket) do
    {:ok, join(socket, @topic)}
  end

  @impl Slipstream
  def handle_join(@topic, _join_response, socket) do
    # an asynchronous push with no reply:
    push(socket, @topic, "hello", %{})

    {:ok, socket}
  end

  @impl Slipstream
  def handle_disconnect(reason, socket) do
    Logger.info "Disconnected, idk. Reason #{reason}"
    reconnect(socket)
  end


  # defp handle_join_reply(_), do: :noop

end
