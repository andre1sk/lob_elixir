defmodule Lob.Validators.Core.ErrorTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Error
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Error)

  test "produces error for nil" do
    rule = %Error{}
    assert validate(rule, nil, %{}, []) == ["error"]
  end

  test "produces error for map" do
    rule = %Error{}
    assert validate(rule, %{}, %{}, []) == ["error"]
  end

  test "produces custom error if set" do
    error = "Oh no!"
    rule = %Error{error: error}
    assert validate(rule, nil, %{}, []) == [error]
  end
end
