defmodule Lob.Validators.Core.ReqTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Req
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Req)

  test "produces no error if value is present" do
    rule = %Req{}
    res = validate(rule, "blah", %{}, [])
    assert res == []
  end

  test "produces error if value is not present" do
    rule = %Req{}
    res = validate(rule, nil, %{}, [])
    assert res == ["value is required"]
  end

end
