defmodule LeakedPasswords do
  @moduledoc """
  Documentation for LeakedPasswords.
  """

  @doc """
  Checks in HIBP if the SHA1 of the password has been leaked to the outside
  world.
  """
  def leaked?(password) when byte_size(password) > 0 do
    password
    |> hashed_password
    |> request_hashlist
    |> match_in_list
  end

  def leaked?(""), do: false

  def hashed_password(password),
    do:
      :crypto.hash(:sha, password)
      |> Base.encode16()

  defp request_hashlist(<<hash_head::bytes-size(5), hash_tail::bytes-size(35)>>),
    do: {hash_tail, HaveIBeenPwnedApi.get!(hash_head).body}

  defp match_in_list({hash, tuple}), do: binsearch(tuple, hash, 0, tuple_size(tuple) - 1)

  defp binsearch(_, _, low, high) when high < low, do: false

  defp binsearch(tuple, value, low, high) do
    (low + high)
    |> div(2)
    |> get_elem(tuple)
    |> compare(value)
    |> recurse(tuple, value, low, high)
  end

  defp compare({_, <<midval::bytes-size(35)>> <> ":" <> count}, midval),
    do: String.to_integer(count)

  defp compare({mid, <<midval::bytes-size(35)>> <> _}, value), do: {mid, bounding(midval > value)}

  defp recurse(count, _, _, _, _) when is_integer(count), do: count
  defp recurse({mid, :lower}, tuple, value, low, _), do: binsearch(tuple, value, low, mid - 1)
  defp recurse({mid, :upper}, tuple, value, _, high), do: binsearch(tuple, value, mid + 1, high)

  defp get_elem(index, tuple), do: {index, elem(tuple, index)}
  defp bounding(true), do: :lower
  defp bounding(false), do: :upper
end
