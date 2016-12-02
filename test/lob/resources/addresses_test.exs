defmodule Lob.Resources.AddressesTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Addresses
  import Lob.Test.Util
  require Lob.Tests.Shared

  Lob.Tests.Shared.resource(Addresses)

  test "create valid US address" do
    address = %{
      name: "John Doe",
      address_line1: "1600 Amphitheatre Parkway",
      address_city: "Mountain View",
      address_state: "CA",
      address_zip: "94043",
      address_country: "US",
    }
    {status, data} = Addresses.create(address, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("adr_")
  end

  test "create invalid US address produces error" do
    address = %{
      name: "John Doe",
      address_line1: "1600 Amphitheatre Parkway",
      address_city: "Mountain View",
      address_state: "CA",
      address_country: "US",
    }
    {status, data} = Addresses.create(address, api_key())
    assert status == :error
    assert data ==  {:validation, %{address_zip: ["value is required"]}}
  end

  test "create valid Int. address" do
    address = %{
      name: "John Doe",
      address_line1: "1600 Amphitheatre Parkway",
      address_city: "Kyiv",
      address_country: "UA",
    }
    {status, data} = Addresses.create(address, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("adr_")
  end

  test "create invalid Int. address" do
    address = %{
      name: "John Doe",
      address_city: "Kyiv",
      address_country: "UA",
    }
    {status, data} = Addresses.create(address, api_key())
    assert status == :error
    assert data == {:validation, %{address_line1: ["value is required"]}}
  end

  test "delete address" do
    address = %{
      name: "John Doe delete",
      address_line1: "1600 Amphitheatre Parkway",
      address_city: "Kyiv",
      address_country: "UA",
    }
    {:ok, data} = Addresses.create(address, api_key())
    {status, data} = Addresses.delete(data.body["id"] , api_key())
    assert status == :ok
    assert data.body["deleted"] == true
  end

  test "verify valid address" do
    address = %{
      name: "John Doe",
      address_line1: "1600 Amphitheatre Parkway",
      address_city: "Mountain View",
      address_state: "CA",
      address_country: "US",
    }
    {status, _} = Addresses.verify(address, api_key())
    assert status == :ok
  end

  test "verify invalid address" do
    address = %{
      name: "John Doe",
      address_line1: "1600 Amphitheatre Parkway",
      address_city: "Mountain View",
      address_state: "YU",
      address_country: "US",
    }
    {status, {type, data}} = Addresses.verify(address, api_key())
    assert status == :error
    assert type == :app
    assert data.status == 404
  end

end
