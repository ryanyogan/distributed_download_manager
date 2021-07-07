defmodule DownloadManager.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor, [topologies(), [name: DownloadManager.ClusterSupervisor]]},
      DownloadManagerWeb.Telemetry,
      {Phoenix.PubSub, name: DownloadManager.PubSub},
      DownloadManager.HordeRegistry,
      DownloadManager.HordeSupervisor,
      DownloadManager.NodeObserver,
      DownloadManager.Download.Repo,
      DownloadManagerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: DownloadManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    DownloadManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp topologies do
    Application.get_env(:libcluster, :topologies) || []
  end
end
