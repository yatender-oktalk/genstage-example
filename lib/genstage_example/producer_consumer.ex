defmodule GenstageExample.ProducerConsumer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [GenstageExample.Producer]}
  end

  def handle_events(events, _from, state) do
    IO.inspect "************"
    IO.inspect events
    IO.inspect "************"
    events_created_at =
      events |> Enum.map(fn x->
        x |> Map.put( :created_at, :erlang.system_time(1))
      end)
      IO.inspect "^^^^^^^^^^^^^^"
    {:noreply, events_created_at, state}
  end
end
