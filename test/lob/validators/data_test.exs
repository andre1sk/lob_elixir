defmodule Lob.Validators.DataTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Data
  import Lob.Validators.Core.Validate

  test "can define Data" do
    rule = %Data{}
    assert rule.__struct__ == Data
  end

  test "produces no errors for nil" do
    rule = %Data{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "produces error for invalid char in key" do
    rule = %Data{}
    assert validate(rule, %{"k\\" => "v"}, %{}, []) |> length == 1
    assert validate(rule, %{"k\"" => "v"}, %{}, []) |> length == 1
  end

  test "produces error for too many pairs" do
    rule = %Data{}
    metadata = for i <- 1..41, into: %{} ,do: {"k" <> to_string(i), "blah"}
    assert validate(rule, metadata, %{}, []) |> length == 1
  end

  test "produces no errors for 40 pairs" do
    rule = %Data{}
    metadata = for i <- 1..40, into: %{} ,do: {"k" <> to_string(i), "blah"}
    assert validate(rule, metadata, %{}, []) == []
  end
end
