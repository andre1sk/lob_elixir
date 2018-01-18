defmodule Lob.Resources.Base do
  @moduledoc """
  Base Module used by most Resource Modules
  """

  @callback name() :: String.t()
  @callback schema() :: map
  @callback create(%{atom => any}, String.t()) :: {:ok, map} | {:error, {atom, map}}
  @callback retrieve(String.t(), String.t()) :: {:ok, map} | {:error, {atom, map}}
  @callback list(map, String.t()) :: {:ok, map} | {:error, {atom, map}}

  def base_uri do
    "https://api.lob.com/v1/"
  end

  defmacro __using__(_params) do
    quote do
      @behaviour Lob.Resources.Base
      alias Lob.Resources.Helpers.Query
      alias Lob.Resources.Helpers.Transform
      alias Lob.Client
      alias Lob.Resources.Base
      alias Lob.Validators.Schema

      def create(data, api_key) do
        uri = Base.base_uri() <> name()
        errors = Schema.validate(schema(), data)
        {status, res} = (errors == %{} && Transform.transform(data)) || {:v_errors, errors}

        case status do
          :ok -> Client.post(uri, res.data, api_key, res.type)
          :error -> {:error, {:encoding, res}}
          :v_errors -> {:error, {:validation, res}}
        end
      end

      def list(query \\ %{}, api_key) when is_map(query) do
        encoded_query = Query.encode(query)
        Client.get(Base.base_uri() <> name() <> encoded_query, api_key)
      end

      def retrieve(id, api_key) do
        Client.get(Base.base_uri() <> name() <> "/" <> URI.encode_www_form(id), api_key)
      end

      defp id_uri(id) when is_binary(id) do
        enc_id = URI.encode_www_form(id)
        {:ok, Lob.Resources.Base.base_uri() <> name() <> "/" <> enc_id}
      end

      defp id_uri(id), do: {:error, "expecting string got #{inspect(id)} instead"}

      defoverridable create: 2, list: 2, retrieve: 2
    end
  end
end
