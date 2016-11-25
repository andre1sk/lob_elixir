defmodule Lob.Resources.AddressesTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Addresses
  import Lob.Test.Util

  test "list no params" do
    {status, _} = Addresses.list(api_key())
    assert status == :ok
  end

  test "list with limit" do
    {status, data} = Addresses.list(%{limit: 5},api_key())
    assert status == :ok
    assert data.body["count"] <= 5
  end

  test "list with total count" do
    {status, data} = Addresses.list(%{limit: 1, include: true}, api_key())
    assert Map.has_key?(data.body, "total_count")
    assert status == :ok
  end

  test "list with metadata" do
    {status, _} = Addresses.list(%{limit: 1, metadata: %{"k"=>"v"}}, api_key())
    assert status == :ok
  end

  test "list with date_created:" do
    {status, _} = Addresses.list(%{limit: 1, date_created: %{gt: "2016-11-19"}}, api_key())
    assert status == :ok
  end

  test "retrieve" do
    {_, data} = Addresses.list(%{limit: 1}, api_key())
    id = (data.body["data"] |> hd)["id"]
    {status, data} = Addresses.retrieve(id, api_key())
    assert status == :ok
    assert data.body["id"] == id
  end

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
