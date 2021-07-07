defmodule DownloadManager do
  @moduledoc """
  DownloadManager keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate start_download(user_id), to: DownloadManager.Download.Tracker, as: :start
  defdelegate fetch_download(user_id), to: DownloadManager.Download.Repo, as: :fetch
  defdelegate delete_download(download), to: DownloadManager.Download.Repo, as: :remove
end
