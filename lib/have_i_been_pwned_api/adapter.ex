defmodule HaveIBeenPwnedApi.Adapter do
  @moduledoc """
  HTTP adapter for the Pwned Passwords API, parsing response lines into a tuple.
  """

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
