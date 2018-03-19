defmodule LeakedPasswords do
  @moduledoc """
  Documentation for LeakedPasswords.
  """

  @doc """
  Checks in HIBP if the SHA1 of the password has been leaked to the outside
  world.
  """
  def leaked?(password) when is_binary(password) do
    password
    |> hashed_password
    |> request_hashlist
    |> match_in_list
  end

  def hashed_password(password),
    do:
      :crypto.hash(:sha, password)
      |> Base.encode16()

  def request_hashlist(<<hash_head::bytes-size(5), hash_tail::bytes-size(35)>>) do
    with %{body: list} <- HaveIBeenPwnedApi.get!(hash_head), do: {hash_tail, list}
  end

  def match_in_list({_, []}), do: false

  def match_in_list({<<hash_tail::bytes-size(35)>>, [head | tail]}),
    do: hash_match?(hash_tail, head) || match_in_list({hash_tail, tail})

  defp hash_match?(hash_tail, entry) do
    [entry_hash, count] = String.split(entry, ":")
    with true <- hash_tail == entry_hash, do: String.to_integer(count)
  end
end
