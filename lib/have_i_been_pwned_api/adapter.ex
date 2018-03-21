defmodule HaveIBeenPwnedApi.Adapter do
  use HTTPoison.Base

  @endpoint "https://api.pwnedpasswords.com/"

  def process_url("/" <> path), do: process_url(path)
  def process_url(path), do: @endpoint <> path

  def process_response_body(body) do
    body
    |> String.split()
    |> List.to_tuple()
  end
end
