defmodule Lob.Validators.Core.BoolTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Bool
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Bool)

  test "produces no errors for nil" do
    rule = %Bool{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "validates true/false correctly" do
    rule = %Bool{}
    assert validate(rule, true, %{}, []) == []
    assert validate(rule, false, %{}, []) == []
  end

  test "produces error for not boolean correctly" do
    rule = %Bool{}
    assert validate(rule, 1, %{}, []) |> length == 1
  end

end
