defmodule Lob.Validators.Core.StrTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Str
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Str)

  test "produces no errors for nil" do
    rule = %Str{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "can validate Str" do
    rule=%Str{}
    res = validate(rule, "blah", %{}, [])
    assert res == []
  end

  test "produces an error if passed something other then binary" do
    rule=%Str{}
    res = validate(rule, %{}, %{}, [])
    assert length(res) > 0
  end

  test "validates max length correctly" do
    rule = %Str{max: 2}
    assert validate(rule, "", %{}, []) == []
    assert validate(rule, "z", %{}, []) == []
    assert validate(rule, "ii", %{}, []) == []
    assert validate(rule, "abc", %{}, []) == ["3 is bigger than max allowed 2"]
  end

  test "ensures max is integer" do
    rule = %Str{max: "2"}
    assert validate(rule, "", %{}, []) == ["max: expecting integer got \"2\" instead"]
  end

  test "validates min length correctly" do
    rule = %Str{min: 3}
    assert validate(rule, "", %{}, []) |> length == 1
    assert validate(rule, "abc", %{}, []) == []
    assert validate(rule, "abcd", %{}, []) == []
  end

  test "ensures min is integer" do
    rule = %Str{min: "a"}
    assert validate(rule, "", %{}, []) == ["min: expecting integer got \"a\" instead"]
  end

  test "validates regex correctly" do
    rule = %Str{regex: ~r/foo/}
    assert validate(rule, "", %{}, []) == ["\"\" did not match regex"]
    assert validate(rule, "foo", %{}, []) == []
    assert validate(rule, "blah foo", %{}, []) == []
  end

  test "ensures regex is regex" do
    rule = %Str{regex: "2"}
    assert validate(rule, "", %{}, []) == ["regex: expecting regex got \"2\" instead"]
  end

  test "in is map or list" do
    assert validate(%Str{in: "2"}, "z", %{}, []) == ["in: expecting map or list got \"2\" instead"]
    assert validate(%Str{in: ["z"]}, "z", %{}, []) == []
    assert validate(%Str{in: %{"z"=>"z"}}, "z", %{}, []) == []
  end

  test "value is in produces no errors" do
    assert validate(%Str{in: ["cool"]}, "cool", %{}, []) == []
  end

  test "value is not in produces error" do
    assert validate(%Str{in: ["cool"]}, "z", %{}, []) == ["\"z\" is not in allowed list"]
  end

end
