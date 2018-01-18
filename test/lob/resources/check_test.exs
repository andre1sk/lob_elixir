defmodule Lob.Resources.CheckTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Checks
  alias Lob.Resources.Addresses
  alias Lob.Resources.BankAccounts
  import Lob.Test.Util
  require Lob.Tests.Shared

  setup_all do
    {:ok, data} = Addresses.list(%{limit: 1}, api_key())
    addr_id = (data.body["data"] |> hd)["id"]
    {:ok, data} = BankAccounts.list(%{limit: 15}, api_key())

    acc_id =
      data.body["data"]
      |> Enum.filter(& &1["verified"])
      |> hd
      |> Map.get("id")

    {:ok, [addr_id: addr_id, acc_id: acc_id]}
  end

  Lob.Tests.Shared.resource(Checks)

  test "creates valid Check", context do
    check = %{
      to: context[:addr_id],
      from: context[:addr_id],
      bank_account: context[:acc_id],
      amount: 10.10
    }

    {status, data} = Checks.create(check, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("chk_")
  end

  test "creates valid Check with logo", context do
    check = %{
      to: context[:addr_id],
      from: context[:addr_id],
      bank_account: context[:acc_id],
      amount: 100.01,
      logo: %{path: "./test/fixtures/logo.png", name: "logo"}
    }

    {status, data} = Checks.create(check, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("chk_")
  end

  test "creates valid Check with check_bottom", context do
    check = %{
      to: context[:addr_id],
      from: context[:addr_id],
      bank_account: context[:acc_id],
      amount: 50.01,
      check_bottom: %{content: "<html style=\"margin-top: 9in\">This is so much fun</html>"}
    }

    {status, data} = Checks.create(check, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("chk_")
  end

  test "creates valid Check with attachment", context do
    check = %{
      to: context[:addr_id],
      from: context[:addr_id],
      bank_account: context[:acc_id],
      amount: 500.99,
      attachment: %{content: "<html>This is best attachment ever</html>"}
    }

    {status, data} = Checks.create(check, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("chk_")
  end

  test "invalid Check produces error", context do
    check = %{
      to: context[:addr_id],
      from: context[:addr_id],
      bank_account: "bank_bad_id",
      amount: 99.00
    }

    {status, _data} = Checks.create(check, api_key())
    assert status == :error
  end
end
