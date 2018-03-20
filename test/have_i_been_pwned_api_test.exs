defmodule HaveIBeenPwnedApiTest do
  use ExUnit.Case

  test "parses the body as a tuple" do
    %{body: body} = HaveIBeenPwnedApi.get!("5eb94")

    assert is_tuple(body)
    assert Enum.all?(Tuple.to_list(body), &Regex.match?(~r/^\S{35}:\d+$/, &1))
  end
end
