defmodule Lob.Validators.CoreTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Str
  import Lob.Validators.Core.Validate

  test "can define Lob.Validators.Core.Str" do
    rule=%Str{}
    assert rule.__struct__==Lob.Validators.Core.Str
  end

  test "can validate Str" do
    rule=%Str{}
    res = validate(rule, "blah", %{}, [])
    assert res == []
  end

  test "produces error if passed something other then binary" do
    rule=%Str{}
    res = validate(rule, %{}, %{}, [])
    assert length(res) > 0
  end

  test "validates max length correctly" do
    rule = %Str{max: 2}
    assert validate(rule, "", %{}, []) == []
    assert validate(rule, "z", %{}, []) == []
    assert validate(rule, "abc", %{}, []) |> length > 0
  end

  test "validates min length correctly" do
    rule = %Str{min: 3}
    assert validate(rule, "", %{}, []) |> length > 0
    assert validate(rule, "abc", %{}, []) == []
    assert validate(rule, "abcd", %{}, []) == []
  end

end
