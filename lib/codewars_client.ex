defmodule CodewarsClient do
  use HTTPoison.Base
  alias Codewars.Client

  @type response ::
    {:ok, any, HTTPoison.Response.t()}
    | {:error, any, HTTPoison.Response.t()}

  def process_request_url(url) do
    "https://www.codewars.com/api/v1" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!(keys: :atoms)
  end
end
