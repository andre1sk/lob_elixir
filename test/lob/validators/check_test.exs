defmodule Lob.Validators.CheckTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Check
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Check)
  Lob.Tests.Shared.schema_meta(Check)

  test "produces errors for empty Check" do
    expect = %{
      amount: ["value is required"],
      bank_account: ["value is required"],
      from: ["value is required"],
      to: ["value is required"]
    }

    assert validate(%Check{}, %{}, %{}, %{}) == expect
  end

  test "produces nor errors for valid Check" do
    data = %{
      amount: 100.00,
      bank_account: "bank_123456789",
      from: "adr_12345678",
      to: ["adr_123123"]
    }

    assert validate(%Check{}, data, %{}, %{}) == %{}
  end

  test "produces error if amount is too big" do
    res = validate(%Check{}, %{amount: 1_000_000.00}, %{}, %{})
    assert Map.has_key?(res, :amount)
  end

  test "produces no error if amount is equal to max" do
    res = validate(%Check{}, %{amount: 999_999.99}, %{}, %{})
    refute Map.has_key?(res, :amount)
  end

  test "produces error if amount is less then min" do
    res = validate(%Check{}, %{amount: 0.001}, %{}, %{})
    assert Map.has_key?(res, :amount)
  end

  test "produces no error if amount is equal to min" do
    res = validate(%Check{}, %{amount: 0.01}, %{}, %{})
    refute Map.has_key?(res, :amount)
  end

  test "bank account needs to start with bank_" do
    res = validate(%Check{}, %{bank_account: "bank_12"}, %{}, %{})
    refute Map.has_key?(res, :bank_account)
    res = validate(%Check{}, %{bank_account: "ban_12"}, %{}, %{})
    assert Map.has_key?(res, :bank_account)
  end

  test "memo should be a string if present" do
    res = validate(%Check{}, %{memo: "cool memo"}, %{}, %{})
    refute Map.has_key?(res, :memo)
    res = validate(%Check{}, %{memo: 0}, %{}, %{})
    assert Map.has_key?(res, :memo)
  end

  test "memo max len 40" do
    stream = Stream.cycle(["a"])
    res = validate(%Check{}, %{memo: Enum.take(stream, 40) |> Enum.join()}, %{}, %{})
    refute Map.has_key?(res, :memo)
    res = validate(%Check{}, %{memo: Enum.take(stream, 41) |> Enum.join()}, %{}, %{})
    assert Map.has_key?(res, :memo)
  end

  test "check number is integer" do
    res = validate(%Check{}, %{check_number: 1}, %{}, %{})
    refute Map.has_key?(res, :check_number)
    res = validate(%Check{}, %{check_number: []}, %{}, %{})
    assert Map.has_key?(res, :check_number)
  end

  test "valid logo produces no errors" do
    data = %{logo: %{path: "./test/fixtures/logo.png", name: "logo"}}
    res = validate(%Check{}, data, %{}, %{})
    refute Map.has_key?(res, :logo)
  end

  test "invalid logo produces  error" do
    data = %{logo: %{path: "./test/fixtures/lo.png", name: "logo"}}
    res = validate(%Check{}, data, %{}, %{})
    assert Map.has_key?(res, :logo)
  end

  test "message max len 400" do
    stream = Stream.cycle(["a", "b", "c"])
    res = validate(%Check{}, %{messsage: Enum.take(stream, 399) |> Enum.join()}, %{}, %{})
    refute Map.has_key?(res, :message)
    res = validate(%Check{}, %{messsage: Enum.take(stream, 400) |> Enum.join()}, %{}, %{})
    refute Map.has_key?(res, :message)
    res = validate(%Check{}, %{message: Enum.take(stream, 401) |> Enum.join()}, %{}, %{})
    assert Map.has_key?(res, :message)
  end

  test "valid check_bottom produces no errors" do
    data = %{check_bottom: %{content: "<html><body>blah</body></html>"}}
    res = validate(%Check{}, data, %{}, %{})
    refute Map.has_key?(res, :check_bottom)
  end

  test "invalid check_bottom produces error" do
    data = %{check_bottom: %{}}
    res = validate(%Check{}, data, %{}, %{})
    assert Map.has_key?(res, :check_bottom)
  end

  test "if both msg and check_bottom are set it produces error" do
    data = %{
      check_bottom: %{content: "<html><body>blah</body></html>"},
      message: "I am a msg"
    }

    res = validate(%Check{}, data, %{}, %{})
    assert Map.has_key?(res, :check_bottom)
    assert Map.has_key?(res, :message)
  end

  test "valid attachment produces no errors" do
    data = %{attachment: %{path: "./test/fixtures/letter.pdf", name: "attachment"}}
    res = validate(%Check{}, data, %{}, %{})
    refute Map.has_key?(res, :attachment)
  end

  test "invalid attachment produces  error" do
    data = %{attachment: %{path: "./test/fixtures/lo.png", name: "logo"}}
    res = validate(%Check{}, data, %{}, %{})
    assert Map.has_key?(res, :attachment)
  end

  test "valid data produces no errors" do
    res = validate(%Check{}, %{data: %{"k" => "v"}}, %{}, %{})
    refute Map.has_key?(res, :data)
  end

  test "invalid data produces  errors" do
    res = validate(%Check{}, %{data: %{"k\"" => "v"}}, %{}, %{})
    assert Map.has_key?(res, :data)
  end

  test "valid mail_type produces no errors" do
    res = validate(%Check{}, %{mail_type: "usps_first_class"}, %{}, %{})
    refute Map.has_key?(res, :mail_type)
    res = validate(%Check{}, %{mail_type: "ups_next_day_air"}, %{}, %{})
    refute Map.has_key?(res, :mail_type)
  end

  test "invalid mail_type produces error" do
    res = validate(%Check{}, %{mail_type: "carrier_pigeon"}, %{}, %{})
    assert Map.has_key?(res, :mail_type)
  end
end
