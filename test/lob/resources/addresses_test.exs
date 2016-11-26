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
    assert data == %{address_zip: ["value is required"]}
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
    assert data == %{address_line1: ["value is required"]}
  end

end
