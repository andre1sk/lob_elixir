defmodule Lob.Resources.BankAccountsTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.BankAccounts
  import Lob.Test.Util
  require Lob.Tests.Shared

  Lob.Tests.Shared.resource(BankAccounts)

  test "creates valid Bank Account" do
    acc =%{
      description: "some account",
      routing_number: "021272655",
      account_number: "123",
      account_type: "company",
      signatory: "Some Dude",
    }
    {status, data} = BankAccounts.create(acc, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("bank_")
  end

  test "invalid Bank Account produces error" do
    acc =%{
      description: "some account",
      routing_number: "zz1272655", #invalid ABA
      account_number: "123",
      account_type: "company",
      signatory: "Some Dude",
    }
    {status, {type, _}} = BankAccounts.create(acc, api_key())
    assert status == :error
    assert type == :app
  end

  test "verify bank account" do
    acc =%{
      description: "verify test",
      routing_number: "021272655",
      account_number: "1235678",
      account_type: "company",
      signatory: "Some Dude",
    }
    {_, data} = BankAccounts.create(acc, api_key())
    id = data.body["id"]
    {status, data} = BankAccounts.verify(id, 5, 10, api_key())
    assert status == :ok
    assert data.body["verified"]
  end

  test "delete bank account" do
    acc =%{
      description: "test delete",
      routing_number: "021272655",
      account_number: "1235678",
      account_type: "company",
      signatory: "Some Dude",
    }
    {_, data} = BankAccounts.create(acc, api_key())
    id = data.body["id"]
    {status, data} = BankAccounts.delete(id, api_key())
    assert status == :ok
    assert data.body["deleted"]
  end

end
