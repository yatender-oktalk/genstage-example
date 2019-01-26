defmodule GenstageExample.Producer do
  use GenStage

  def start_link(state \\ []) do
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    schedule_work()
    {:producer, state}
  end

  def handle_demand(demand, state) when demand > 0 do
    events = Enum.take(state, demand)
    # IO.inspect "state"
    # IO.inspect state
    # IO.inspect("demand")
    # IO.inspect(demand)
    {:noreply, events, state -- events}
  end

  # def handle_cast({:push, events}, state) do
  #   IO.inspect events100
  #   IO.inspct "hello"
  #   updated_list = state ++ events
  #   {:noreply, state, updated_list}
  # end

  def handle_info(:polling, state) do
    list = 1..12000 |> Enum.map(fn _x ->
      num = Enum.take_random(1..1000, 2)
      %{
        a: num
      }
    end)

    new_state = state ++ list

    schedule_work()
    {:noreply, state, new_state}
  end

  @doc """
  adding an event to the queue
  """
  def add(events) do
    GenStage.cast(__MODULE__, {:push, events})
  end

  defp schedule_work() do
    Process.send_after(self(), :polling, 2000)
  end


end
