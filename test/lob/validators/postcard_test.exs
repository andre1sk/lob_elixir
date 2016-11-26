defmodule Lob.Validators.PostcardTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Postcard
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Postcard)

  test "produces errors for empty postcard" do
    expect = %{front: ["value is required"], to: ["value is required"], message: [":back or :messages is required"]}
    assert validate(%Postcard{}, %{}, %{}, %{}) == expect
  end

  test "valid address_id produces no errors" do
    id="adr_8bad937e10c42730"
    res = validate(%Postcard{}, %{to: id}, %{}, %{})
    refute Map.has_key?(res, :to)
    res2 = validate(%Postcard{}, %{from: id}, %{}, %{})
    refute Map.has_key?(res2, :from)
  end

  test "invalid address_id produces error" do
    id="ad_8bad937e10c42730"
    res = validate(%Postcard{}, %{to: id}, %{}, %{})
    assert Map.has_key?(res, :to)
    res2 = validate(%Postcard{}, %{from: id}, %{}, %{})
    assert Map.has_key?(res2, :from)
  end

  test "valid US address produces no errors" do
    address = %{
      name: "Some Name",
      address_country: "US",
      address_line1: "1 Elixir Way",
      address_city: "Beam",
      address_state: "CA",
      address_zip: "94103-1910"
    }
    res = validate(%Postcard{}, %{to: address}, %{}, %{})
    refute Map.has_key?(res, :to)
    res2 = validate(%Postcard{}, %{from: address}, %{}, %{})
    refute Map.has_key?(res2, :from)
  end

  test "invalid US address produces  errors" do
    address = %{
      name: "Some Name",
      address_country: "US",
      address_line1: "1 Elixir Way",
      address_city: "Beam",
      address_state: "PP",
      address_zip: "94103-1910"
    }
    res = validate(%Postcard{}, %{to: address}, %{}, %{})
    assert Map.has_key?(res, :to)
    res2 = validate(%Postcard{}, %{from: address}, %{}, %{})
    assert Map.has_key?(res2, :from)
  end

  test "valid Int. address produces no errors" do
    address = %{
      name: "Some Name",
      address_country: "DK",
      address_line1: "1 Elixir Way",
      address_city: "Beam",
      address_zip: "z941031910"
    }
    res = validate(%Postcard{}, %{to: address}, %{}, %{})
    refute Map.has_key?(res, :to)
    res2 = validate(%Postcard{}, %{from: address}, %{}, %{})
    refute Map.has_key?(res2, :from)
  end

  test "invalid Int. address produces errors" do
    address = %{
      name: "Some Name",
      address_country: "ZZ",
    }
    res = validate(%Postcard{}, %{to: address}, %{}, %{})
    assert Map.has_key?(res, :to)
    res2 = validate(%Postcard{}, %{from: address}, %{}, %{})
    assert Map.has_key?(res2, :from)
  end

  test "files with valid path and name produce no errors" do
    path = "./test/fixtures/letter.pdf"
    res = validate(%Postcard{},
      %{
        front: %{path: path, name: "front"},
        back: %{path: path, name: "back"},
       }, %{}, %{})
    refute Map.has_key?(res, :front)
    refute Map.has_key?(res, :back)
  end

  test "files with invalid path and name produce errors" do
    path = "./test/fixtures/not_letter.pdf"
    res = validate(%Postcard{},
      %{
        front: %{path: path, name: "front"},
        back: %{path: path, name: "back"},
       }, %{}, %{})
    assert Map.has_key?(res, :front)
    assert Map.has_key?(res, :back)
  end

  test "valid data produces no errors" do
    res = validate(%Postcard{}, %{data: %{"k"=>"v"}}, %{}, %{})
    refute Map.has_key?(res, :data)
  end

  test "invalid data produces  errors" do
    res = validate(%Postcard{}, %{data: %{"k\""=>"v"}}, %{}, %{})
    assert Map.has_key?(res, :data)
  end

  test "valid message produces no errors" do
    res = validate(%Postcard{}, %{message: "cool msg"}, %{}, %{})
    refute Map.has_key?(res, :message)
  end

  test "invalid message produces error" do
    msg = (for _ <- 1..351, do: "k") |> Enum.join
    res = validate(%Postcard{}, %{message: msg}, %{}, %{})
    assert Map.has_key?(res, :message)
  end

  test "valid size produces no errors" do
    res = validate(%Postcard{}, %{size: "4x6"}, %{}, %{})
    refute Map.has_key?(res, :size)
    res = validate(%Postcard{}, %{size: "6x9"}, %{}, %{})
    refute Map.has_key?(res, :size)
    res = validate(%Postcard{}, %{size: "6x11"}, %{}, %{})
    refute Map.has_key?(res, :size)
  end

  test "invalid size produces  error" do
    res = validate(%Postcard{}, %{size: "4x13"}, %{}, %{})
    assert Map.has_key?(res, :size)
  end

  test "valid metadata produces no errors" do
    res = validate(%Postcard{}, %{metadata: %{"k"=>"v"}}, %{}, %{})
    refute Map.has_key?(res, :metadata)
  end

  test "invalid metadata produces an error" do
    res = validate(%Postcard{}, %{metadata: %{"k\\"=>"v"}}, %{}, %{})
    assert Map.has_key?(res, :metadata)
  end

end
