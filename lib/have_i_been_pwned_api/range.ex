defmodule HaveIBeenPwnedApi.Range do
  @adapter Application.get_env(:leaked_passwords, :adapter)

  def get(<<hash_prefix::bytes-size(5)>>) do
    @adapter.request(:get, "/range/" <> hash_prefix)
  end

  def get!(<<hash_prefix::bytes-size(5)>>) do
    @adapter.request!(:get, "/range/" <> hash_prefix)
  end
end
