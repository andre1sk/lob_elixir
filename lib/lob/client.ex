defmodule Lob.Client do
  def get(uri, api_key) do
    HTTPoison.get(uri, [], options(api_key)) |> res
  end

  def post(uri, body, api_key, type \\ :form) when type == :form or type == :multipart do
    HTTPoison.post(uri, {type, body}, [], options(api_key)) |> res
  end

  def delete(uri, body \\ "", api_key) do
    HTTPoison.request(:delete, uri, body, [], options(api_key)) |> res
  end

  defp res({:error, error}), do: {:error, {:network, error}}

  defp res({:ok, resp}) do
    body = Poison.decode!(resp.body)
    ok? = resp.status_code < 400

    (!ok? &&
       {:error, {:app, %{error: body["error"], headers: resp.headers, status: resp.status_code}}}) ||
      {:ok, %{body: body, headers: resp.headers, status: resp.status_code}}
  end

  defp options(api_key) when is_binary(api_key) do
    [hackney: [basic_auth: {api_key, ""}]]
  end
end
