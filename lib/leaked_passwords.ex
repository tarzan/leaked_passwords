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

  def request_hashlist(<<hash_head::bytes-size(5), hash_tail::bytes-size(35)>>),
    do: {hash_tail, HaveIBeenPwnedApi.get!(hash_head).body}

  defp match_in_list({hash, tuple}), do: binsearch(tuple, hash, 0, tuple_size(tuple) - 1)

  defp binsearch(_, _, low, high) when high < low, do: false

  defp binsearch(tuple, value, low, high) do
    mid = div(low + high, 2)
    <<midval::bytes-size(35)>> <> ":" <> count = elem(tuple, mid)

    cond do
      value < midval -> binsearch(tuple, value, low, mid - 1)
      value > midval -> binsearch(tuple, value, mid + 1, high)
      value == midval -> String.to_integer(count)
    end
  end
end
