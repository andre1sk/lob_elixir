defmodule Lob.Validators.Core.FloatingPointTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.FloatingPoint
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(FloatingPoint)

  test "produces no errors for nil" do
    rule = %FloatingPoint{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "validates max correctly" do
    rule = %FloatingPoint{max: 2.0}
    assert validate(rule, 0.0, %{}, []) == []
    assert validate(rule, 1.0, %{}, []) == []
    assert validate(rule, 2.0, %{}, []) == []
    assert validate(rule, 2.1, %{}, []) == ["2.1 is bigger than max allowed 2.0"]
  end

  test "validates min correctly" do
    rule = %FloatingPoint{min: 2.0}
    assert validate(rule, 0.0, %{}, []) == ["0.0 is less than min allowed  2.0"]
    assert validate(rule, 1.0, %{}, []) == ["1.0 is less than min allowed  2.0"]
    assert validate(rule, 2.0, %{}, []) == []
    assert validate(rule, 2.1, %{}, []) == []
  end
end
