defmodule HaveIBeenPwnedApi.Range do
  @moduledoc """
  Fetches Pwned Passwords hash ranges using a five-character SHA-1 prefix.
  """

  @default_adapter HaveIBeenPwnedApi.Adapter

  def get(<<hash_prefix::bytes-size(5)>>) do
    adapter().request(:get, "/range/" <> String.upcase(hash_prefix))
  end

  def get!(<<hash_prefix::bytes-size(5)>>) do
    adapter().request!(:get, "/range/" <> String.upcase(hash_prefix))
  end

  defp adapter, do: Application.get_env(:leaked_passwords, :adapter) || @default_adapter
end
