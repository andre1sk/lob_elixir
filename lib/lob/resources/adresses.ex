defmodule Lob.Resources.Addresses do
  @moduledoc """
  Functions for working with Addresses API endpoint
  """

  alias Lob.Schemas.Address
  use Lob.Resources.Base

  def name, do: "addresses"

  def schema, do: Address.schema()

  def delete(id, api_key) do
    case id_uri(id) do
      {:ok, uri} -> Client.delete(uri, api_key)
      {:error, error} -> {:error, error}
    end
  end

end
