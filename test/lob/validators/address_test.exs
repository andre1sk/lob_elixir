defmodule Lob.Validators.AddressTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Address
  import Lob.Validators.Core.Validate

  test "produces errors for empty address" do
    expect = %{address_line1: ["value is required"],
      company: [":name or :company is required"],
      name: [":name or :company is required"]}
    assert validate(%Address{}, %{}, %{}, %{}) == expect
  end

  test "produces no errors for minimal international address" do
    address = %{name: "John Doe", address_country: "FJ", address_line1: "F1 Drive"}
    assert validate(%Address{}, address, %{}, %{}) == %{}
  end

  test "produces errors for empty US address" do
    expect = %{address_city: ["value is required"],
      address_line1: ["value is required"],
      address_state: ["value is required"],
      address_zip: ["value is required"],
      company: [":name or :company is required"],
      name: [":name or :company is required"]}
    assert validate(%Address{}, %{address_country: "US"}, %{}, %{}) == expect
  end

  test "produces no errors for minimal US address" do
    address = %{name: "John Doe", address_country: "US",
      address_line1: "F1 Drive", address_city: "Fun",
      address_state: "MI", address_zip: "48823"}
    assert validate(%Address{}, address, %{}, %{}) == %{}
  end
end
