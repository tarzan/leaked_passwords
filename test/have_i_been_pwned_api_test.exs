defmodule HaveIBeenPwnedApi.RangeTest do
  use ExUnit.Case

  alias HaveIBeenPwnedApi.Range

  test "parses the body as a tuple" do
    %{body: body} = Range.get!("5EB94")

    assert is_tuple(body)
    assert Enum.all?(Tuple.to_list(body), &Regex.match?(~r/^\S{35}:\d+$/, &1))
  end

  test "is case insensitive" do
    assert Range.get!("5EB94") == Range.get!("5eb94")
  end

  test "raises on timeout" do
    assert_raise HTTPoison.Error, ":timeout", fn ->
      Range.get!("FAC88")
    end
  end
end
