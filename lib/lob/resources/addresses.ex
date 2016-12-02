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
      {:error, error} -> {:error, {:encoding, error}}
    end
  end

  def verify(address, api_key) do
    uri = Base.base_uri <> "verify"
    {status, res} = Transform.transform(address)
    case status do
      :ok -> Client.post(uri, res.data, api_key, res.type)
      :error -> {:error, {:encoding, res}}
    end
  end

end
