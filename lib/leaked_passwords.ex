defmodule LeakedPasswords do
  @moduledoc """
  Documentation for LeakedPasswords.
  """

  alias HaveIBeenPwnedApi.Range

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
    do: {hash_tail, Range.get!(hash_head).body}

  defp match_in_list({hash, tuple}), do: binsearch(tuple, hash, 0, tuple_size(tuple) - 1)

  defp binsearch(_, _, lower_bound, upper_bound)
       when upper_bound < lower_bound,
       do: false

  defp binsearch(tuple, value, lower_bound, upper_bound) do
    {lower_bound, upper_bound}
    |> calculate_middle_index()
    |> get_elem(tuple)
    |> compare(value)
    |> recurse(tuple, value, lower_bound, upper_bound)
  end

  defp calculate_middle_index({lower, upper}), do: (lower + upper) |> div(2)
  defp get_elem(index, tuple), do: {index, elem(tuple, index)}

  defp compare({_, <<hit::bytes-size(35)>> <> ":" <> count}, hit), do: String.to_integer(count)

  defp compare({index, <<entry::bytes-size(35)>> <> _}, value),
    do: {index, evaluate(entry > value)}

  defp evaluate(true), do: :lower
  defp evaluate(false), do: :upper

  defp recurse(count, _, _, _, _) when is_integer(count), do: count

  defp recurse({index, :lower}, tuple, value, lower_bound, _),
    do: binsearch(tuple, value, lower_bound, index - 1)

  defp recurse({index, :upper}, tuple, value, _, upper_bound),
    do: binsearch(tuple, value, index + 1, upper_bound)
end
