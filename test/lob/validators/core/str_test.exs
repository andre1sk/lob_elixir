defmodule Lob.Validators.Core.StrTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Str
  import Lob.Validators.Core.Validate

  test "can define Lob.Validators.Core.Str" do
    rule=%Str{}
    assert rule.__struct__== Str
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
    assert validate(rule, "abc", %{}, []) |> length == 1
  end

  test "ensures max is integer" do
    rule = %Str{max: "2"}
    assert validate(rule, "", %{}, []) |> length == 1
  end

  test "validates min length correctly" do
    rule = %Str{min: 3}
    assert validate(rule, "", %{}, []) |> length == 1
    assert validate(rule, "abc", %{}, []) == []
    assert validate(rule, "abcd", %{}, []) == []
  end

  test "ensures min is integer" do
    rule = %Str{min: "2"}
    assert validate(rule, "", %{}, []) |> length == 1
  end

  test "validates regex correctly" do
    rule = %Str{regex: ~r/foo/}
    assert validate(rule, "", %{}, []) |> length == 1
    assert validate(rule, "foo", %{}, []) == []
    assert validate(rule, "blah foo", %{}, []) == []
  end

  test "ensures regex is regex" do
    rule = %Str{regex: "2"}
    assert validate(rule, "", %{}, []) |> length == 1
  end

  test "in is map or list" do
    assert validate(%Str{in: "2"}, "z", %{}, []) |> length == 1
    assert validate(%Str{in: ["z"]}, "z", %{}, []) == []
    assert validate(%Str{in: %{"z"=>"z"}}, "z", %{}, []) == []
  end

  test "value is in produces no errors" do
    assert validate(%Str{in: ["cool"]}, "cool", %{}, []) == []
  end

  test "value is not in produces error" do
    assert validate(%Str{in: ["cool"]}, "z", %{}, []) |> length == 1
  end

  test "apply? is implemented" do
    assert  apply?(%Str{}, %{}) == true
  end

  test "apply? is flase if apply? func returns false" do
    rule = %Str{apply?: &(&1[:it] != :what)}
    assert  apply?(rule, %{it: :what}) == false
  end


end
