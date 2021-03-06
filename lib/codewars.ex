defmodule Codewars do
  use HTTPoison.Base
  alias Codewars.Client

  @type response ::
    {:ok, any, HTTPoison.Response.t()}
    | {:error, any, HTTPoison.Response.t()}

  @spec get(binary, Client.t(), any) :: response
  def get(path, client, params \\ []) do
    uri = client |> url(path) |> add_params(params)
    request!(:get, uri, "", client |> headers) |> process_response
  end

  def process_response_body(body) do
    body
    |> Poison.decode!(keys: :atoms)
  end

  @spec process_response(HTTPoison.Response.t() | {integer, any, HTTPoison.Response.t()}) :: response
  def process_response(%HTTPoison.Response{status_code: status_code, body: body} = resp), do: {status_code, body, resp}
  def process_response({_status_code, _, %HTTPoison.Response{} = resp}), do: process_response(resp)

  @spec url(Client.t, binary) :: binary
  defp url(_client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  @spec add_params(binary, list) :: binary
  defp add_params(url, params) do
    url |> URI.parse |> merge_params(params) |> String.Chars.to_string
  end

  @spec merge_params(URI.t, list) :: URI.t
  defp merge_params(uri, []), do: uri
  defp merge_params(%URI{query: nil} = uri, params) when is_list(params) or is_map(params) do
    uri |> Map.put(:query, URI.encode_query(params))
  end
  defp merge_params(%URI{} = uri, params) when is_list(params) or is_map(params) do
    uri |> Map.update!(:query, fn q -> q |> URI.decode_query |> Map.merge(param_map(params)) |> URI.encode_query end)
  end

  @spec param_map(list) :: map
  defp param_map(list) when is_list(list) or is_map(list) do
    for {key, value} <- list, into: Map.new, do: {"#{key}", value}
  end

  defp headers(%Client{token: nil}), do: []
  defp headers(%Client{token: token}), do: [{"Authorization", "token #{token}"}]
end
