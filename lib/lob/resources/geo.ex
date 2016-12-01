defmodule Lob.Resources.Geo do
  @moduledoc """
    Base Module used by simple list Rsources
  """
  @callback list(String.t) :: {:ok | :error, map}

  defmacro __using__(params) do
    quote do
      @behaviour Lob.Resources.Geo
      alias Lob.Client
      alias Lob.Resources.Base

      def list(api_key) do
        case Client.get(Base.base_uri() <> unquote(params[:name]), api_key) do
          {:ok, res}      -> {:ok, format(res)}
          {:error, error} -> {:error, error}
        end
      end

      defp format(res) do
        res.body["data"]
        |> Enum.reduce(%{}, &(Map.put(&2, &1["short_name"], &1["name"])))
      end
    end
  end
end
