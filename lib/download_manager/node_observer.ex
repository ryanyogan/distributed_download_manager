defmodule DownloadManager.NodeObserver do
  use GenServer

  alias DownloadManager.{HordeRegistry, HordeSupervisor}

  def start_link(_opts), do: GenServer.start_link(__MODULE__, [])

  @impl true
  def init(_opts) do
    :net_kernel.monitor_nodes(true, node_type: :visible)

    {:ok, nil}
  end

  @impl true
  def handle_info({:nodeup, _node, _type}, state) do
    set_members(HordeRegistry)
    set_members(HordeSupervisor)

    {:noreply, state}
  end

  def handle_info({:nodedown, _node, _type}, state) do
    set_members(HordeRegistry)
    set_members(HordeSupervisor)

    {:noreply, state}
  end

  defp set_members(name) do
    members = Enum.map([Node.self() | Node.list()], &{name, &1})

    :ok = Horde.Cluster.set_members(name, members)
  end
end
