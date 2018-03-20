defmodule HaveIBeenPwnedApi do
  use HTTPoison.Base

  @endpoint "https://api.pwnedpasswords.com/range/"

  def process_url(<<hash_prefix::bytes-size(5)>>), do: @endpoint <> hash_prefix

  def process_response_body(body) do
    body
    |> String.split()
    |> List.to_tuple()
  end
end
