defmodule Lob.Validators.BankAccountTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.BankAccount
  import Lob.Validators.Core.Validate

  test "produces errors for empty account" do
    expect = %{
      account_number: ["value is required"],
      account_type: ["value is required"],
      routing_number: ["value is required"],
      signatory: ["value is required"]
    }
    assert validate(%BankAccount{}, %{}, %{}, %{}) == expect
  end

  test "produces no errors for valid account" do
    acc = %{
      account_number: "a123423",
      account_type: "company",
      routing_number: "123456789",
      signatory: "The Dude"
    }
    assert validate(%BankAccount{}, acc, %{}, %{}) == %{}
  end

  test "valid metadata produces no errors" do
    res = validate(%BankAccount{}, %{metadata: %{"k"=>"v"}}, %{}, %{})
    refute Map.has_key?(res, :metadata)
  end

  test "invalid metadata produces an error" do
    res = validate(%BankAccount{}, %{metadata: %{"k\\"=>"v"}}, %{}, %{})
    assert Map.has_key?(res, :metadata)
  end
end
