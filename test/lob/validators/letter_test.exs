defmodule Lob.Validators.LetterTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Letter
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Letter)
  Lob.Tests.Shared.schema_meta(Letter)

  test "produces errors for empty letter" do
    expect = %{color: ["value is required"], file: ["value is required"],
      from: ["value is required"], to: ["value is required"]}
    assert validate(%Letter{}, %{}, %{}, %{}) == expect
  end

  test "validates color correctly" do
    res = validate(%Letter{}, %{color: true}, %{}, %{})
    refute Map.has_key?(res, :color)
    res2 = validate(%Letter{}, %{color: false}, %{}, %{})
    refute Map.has_key?(res2, :color)
    res3 = validate(%Letter{}, %{color: "it"}, %{}, %{})
    assert Map.has_key?(res3, :color)
  end

  test "valid address_id produces no errors" do
    id="adr_8bad937e10c42730"
    res = validate(%Letter{}, %{to: id}, %{}, %{})
    refute Map.has_key?(res, :to)
    res2 = validate(%Letter{}, %{from: id}, %{}, %{})
    refute Map.has_key?(res2, :from)
  end

  test "invalid address_id produces error" do
    id="ad_8bad937e10c42730"
    res = validate(%Letter{}, %{to: id}, %{}, %{})
    assert Map.has_key?(res, :to)
    res2 = validate(%Letter{}, %{from: id}, %{}, %{})
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
    res = validate(%Letter{}, %{to: address}, %{}, %{})
    refute Map.has_key?(res, :to)
    res2 = validate(%Letter{}, %{from: address}, %{}, %{})
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
    res = validate(%Letter{}, %{to: address}, %{}, %{})
    assert Map.has_key?(res, :to)
    res2 = validate(%Letter{}, %{from: address}, %{}, %{})
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
    res = validate(%Letter{}, %{to: address}, %{}, %{})
    refute Map.has_key?(res, :to)
    res2 = validate(%Letter{}, %{from: address}, %{}, %{})
    refute Map.has_key?(res2, :from)
  end

  test "invalid Int. address produces errors" do
    address = %{
      name: "Some Name",
      address_country: "ZZ",
    }
    res = validate(%Letter{}, %{to: address}, %{}, %{})
    assert Map.has_key?(res, :to)
    res2 = validate(%Letter{}, %{from: address}, %{}, %{})
    assert Map.has_key?(res2, :from)
  end

  test "valid file produces no errors" do
    path = "./test/fixtures/letter.pdf"
    res = validate(%Letter{}, %{file: %{path: path, name: "file"}}, %{}, %{})
    refute Map.has_key?(res, :file)
  end

  test "invalid file produces error" do
    path = "./test/fixtures/not.pdf"
    res = validate(%Letter{}, %{file: %{path: path, name: "file"}}, %{}, %{})
    assert Map.has_key?(res, :file)
  end

  test "valid data produces no errors" do
    res = validate(%Letter{}, %{data: %{"k"=>"v"}}, %{}, %{})
    refute Map.has_key?(res, :data)
  end

  test "invalid data produces  errors" do
    res = validate(%Letter{}, %{data: %{"k\""=>"v"}}, %{}, %{})
    assert Map.has_key?(res, :data)
  end

  test "validates double_sided correctly" do
    res = validate(%Letter{}, %{double_sided: true}, %{}, %{})
    refute Map.has_key?(res, :double_sided)
    res2 = validate(%Letter{}, %{double_sided: false}, %{}, %{})
    refute Map.has_key?(res2, :double_sided)
    res3 = validate(%Letter{}, %{double_sided: :z}, %{}, %{})
    assert Map.has_key?(res3, :double_sided)
  end

  test "validates address_placement correctly" do
    res = validate(%Letter{}, %{address_placement: "top_first_page"}, %{}, %{})
    refute Map.has_key?(res, :address_placement)
    res2 = validate(%Letter{}, %{address_placement: "insert_blank_page"}, %{}, %{})
    refute Map.has_key?(res2, :address_placement)
    res3 = validate(%Letter{}, %{address_placement: "z"}, %{}, %{})
    assert Map.has_key?(res3, :address_placement)
  end

  test "validates return_envelope correctly" do
    res = validate(%Letter{}, %{return_envelope: true}, %{}, %{})
    refute Map.has_key?(res, :return_envelope)
    res2 = validate(%Letter{}, %{return_envelope: false}, %{}, %{})
    refute Map.has_key?(res2, :return_envelope)
    res3 = validate(%Letter{}, %{return_envelope: 15}, %{}, %{})
    assert Map.has_key?(res3, :return_envelope)
  end

  test "if return_envelope is true and perforated_page not set produces error" do
    res = validate(%Letter{}, %{return_envelope: true}, %{}, %{})
    assert Map.has_key?(res, :perforated_page)
  end

  test "valid perforated_page produces no errors" do
    res = validate(%Letter{}, %{perforated_page: 1}, %{}, %{})
    refute Map.has_key?(res, :perforated_page)
  end

  test "invalid perforated_page produces error" do
    res = validate(%Letter{}, %{perforated_page: 0}, %{}, %{})
    assert Map.has_key?(res, :perforated_page)
  end

  test "validates extra_service correctly" do
    res = validate(%Letter{}, %{extra_service: "certified"}, %{}, %{})
    refute Map.has_key?(res, :extra_service)
    res2 = validate(%Letter{}, %{extra_service: "registered"}, %{}, %{})
    refute Map.has_key?(res2, :extra_service)
    res3 = validate(%Letter{}, %{extra_service: []}, %{}, %{})
    assert Map.has_key?(res3, :extra_service)
  end

end
