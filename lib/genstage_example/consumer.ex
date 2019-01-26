defmodule GenstageExample.Consumer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [GenstageExample.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      event
    end
    # As a consumer we never emit events
    IO.inspect("state")
    IO.inspect(state)
    {:noreply, [], state}
  end
end
