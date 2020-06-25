defmodule HaveIBeenPwnedApi.Range do
  @default_adapter HaveIBeenPwnedApi.Adapter

  def get(<<hash_prefix::bytes-size(5)>>) do
    adapter().request(:get, "/range/" <> String.upcase(hash_prefix))
  end

  def get!(<<hash_prefix::bytes-size(5)>>) do
    adapter().request!(:get, "/range/" <> String.upcase(hash_prefix))
  end

  defp adapter, do: Application.get_env(:leaked_passwords, :adapter) || @default_adapter
end
