defmodule Lob.Validators.Core.IntTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Int
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Int)

  test "produces no errors for nil" do
    rule = %Int{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "validates max correctly" do
    rule = %Int{max: 2}
    assert validate(rule, 0, %{}, []) == []
    assert validate(rule, 1, %{}, []) == []
    assert validate(rule, 2, %{}, []) == []
    assert validate(rule, 3, %{}, []) |> length == 1
  end

  test "validates min correctly" do
    rule = %Int{min: 2}
    assert validate(rule, 0, %{}, []) |> length == 1
    assert validate(rule, 1, %{}, []) |> length == 1
    assert validate(rule, 2, %{}, []) == []
    assert validate(rule, 3, %{}, []) == []
  end

end
