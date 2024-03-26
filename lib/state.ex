defmodule ConfigReader.State do
  use GenServer

  alias ConfigReader.FileProcessor

  # Client

  @doc """
  Starts a new instance of the State GenServer
  """
  def start_link([]) do
    GenServer.start_link(__MODULE__, %{})
  end

  @doc """
  Fetches a value from the state by key
  """
  def get(pid, key) do
    GenServer.call(pid, {:lookup, key})
  end

  @doc """
  Reloads config file from disk to update internal state
  """
  def reload_config(pid) do
    GenServer.cast(pid, {:reload})
  end

  # Server implementation

  @impl true
  def init(_items) do
    {:ok, FileProcessor.read_file()}
  end

  @impl true
  def handle_call({:lookup, key}, _from, state) do
    case Map.fetch(state, key) do
      {:ok, value} -> {:reply, value, state}
      :error -> {:reply, "Key #{key} not found", state}
    end
  end

  @impl true
  def handle_cast({:reload}, _state) do
    {:noreply, FileProcessor.read_file()}
  end
end
