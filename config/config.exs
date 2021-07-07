use Mix.Config

config :download_manager, DownloadManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yhlabG8N32RJnL7GHlbsGlHT2cTVcXDj0sRKbhNKdx0RDeg7ss738l+6QN6QVfZ5",
  render_errors: [view: DownloadManagerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DownloadManager.PubSub,
  live_view: [signing_salt: "bh0d8vfQ"]

config :download_manager, DownloadManager.Download.Repo,
  adapter: DownloadManager.Download.Repo.Nebulex

config :download_manager, DownloadManager.Download.Tracker.Worker,
  adapter: DownloadManager.Download.Tracker.Worker.Fake

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
