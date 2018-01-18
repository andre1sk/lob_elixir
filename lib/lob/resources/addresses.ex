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
    endpoint =
      case Map.get(address, :address_country, "US") do
        "US" -> "us_verifications"
        _ -> "intl_verifications"
      end

    uri = Base.base_uri() <> endpoint
    {status, res} = verify_adj(address) |> Transform.transform()

    case status do
      :ok -> Client.post(uri, res.data, api_key, res.type)
      :error -> {:error, {:encoding, res}}
    end
  end

  defp verify_adj(address) do
    address
    |> Map.delete(:name)
    |> (&((Map.get(&1, :address_country) == "US" && Map.delete(&1, :address_country)) || &1)).()
    |> change_if_exists(:address_country, :country)
    |> change_if_exists(:address_line1, :primary_line)
    |> change_if_exists(:address_line2, :secondary_line)
    |> change_if_exists(:address_city, :city)
    |> change_if_exists(:address_state, :state)
    |> change_if_exists(:address_zip, :zip)
  end

  defp change_if_exists(address, key, to_key) do
    ((Map.has_key?(address, key) && Map.put(address, to_key, address[key])) || address)
    |> Map.delete(key)
  end
end
