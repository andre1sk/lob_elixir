defmodule Lob.Validators.Core.BoolTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Bool
  import Lob.Validators.Core.Validate

  test "can define Lob.Validators.Core.Str" do
    rule=%Bool{}
    assert rule.__struct__== Bool
  end

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

  test "apply? is implemented" do
    assert  apply?(%Bool{}, %{}) == true
  end

  test "apply? is flase if apply? func returns false" do
    rule = %Bool{apply?: &(&1[:it] != :what)}
    assert  apply?(rule, %{it: :what}) == false
  end


end
