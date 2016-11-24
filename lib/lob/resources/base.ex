defmodule Lob.Resources.Base do
  @moduledoc """
  Base Module used by all other Resource Modules
  """

  @callback name() :: String.t
  @callback schema() :: map

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
        errors = Schema.validate(schema, data)
        {status, res} = (errors == %{}) && Transform.transform(data) || {:error, errors}
        case status do
          :ok -> Client.post(Base.base_uri() <> name(), res.data, api_key, res.type)
          :error -> {:error, res}
        end
      end

      def list(query \\%{}, api_key) when is_map(query) do
        encoded_query = Query.encode(query)
        Client.get(Base.base_uri() <> name() <> encoded_query, api_key)
      end

      def retrieve(id, api_key) do
        Client.get(Base.base_uri() <> name() <> "/" <> URI.encode_www_form(id), api_key)
      end

    end
  end
end
