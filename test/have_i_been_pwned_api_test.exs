defmodule HaveIBeenPwnedApiTest do
  use ExUnit.Case

  test "parses the body" do
    assert [head | _tail] = HaveIBeenPwnedApi.get!("5eb94").body
    assert Regex.match?(~r/^\S{35}:\d+$/, head)
  end
end
