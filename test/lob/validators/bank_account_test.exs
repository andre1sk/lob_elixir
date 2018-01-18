defmodule Lob.Validators.BankAccountTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.BankAccount
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(BankAccount)
  Lob.Tests.Shared.schema_meta(BankAccount)

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
end
