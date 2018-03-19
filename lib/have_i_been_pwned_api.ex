defmodule HaveIBeenPwnedApi do
  use HTTPoison.Base

  def process_url(url) do
    "https://api.pwnedpasswords.com/range/" <> url
  end

  def process_response_body(body), do: String.split(body)
end
