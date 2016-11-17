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

end
