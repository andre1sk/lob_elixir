defmodule Lob.Resources.BankAccountsTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.BankAccounts
  import Lob.Test.Util

  test "list no params" do
    {status, _} = BankAccounts.list(api_key())
    assert status == :ok
  end

  test "list with limit" do
    {status, data} = BankAccounts.list(%{limit: 5},api_key())
    assert status == :ok
    assert data.body["count"] <= 5
  end

  test "list with total count" do
    {status, data} = BankAccounts.list(%{limit: 1, include: true}, api_key())
    assert Map.has_key?(data.body, "total_count")
    assert status == :ok
  end

  test "list with metadata" do
    {status, _} = BankAccounts.list(%{limit: 1, metadata: %{"k"=>"v"}}, api_key())
    assert status == :ok
  end

  test "list with date_created:" do
    {status, _} = BankAccounts.list(%{limit: 1, date_created: %{gt: "2016-11-19"}}, api_key())
    assert status == :ok
  end

  test "retrieve" do
    {_, data} = BankAccounts.list(%{limit: 1}, api_key())
    id = (data.body["data"] |> hd)["id"]
    {status, data} = BankAccounts.retrieve(id, api_key())
    assert status == :ok
    assert data.body["id"] == id
  end

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
    {status, _} = BankAccounts.create(acc, api_key())
    assert status == :error
  end

end
