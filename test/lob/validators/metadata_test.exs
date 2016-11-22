defmodule Lob.Validators.MetadataTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Metadata
  import Lob.Validators.Core.Validate

  test "can define metadata" do
    rule = %Metadata{}
    assert rule.__struct__ == Metadata
  end

  test "produces no errors for nil" do
    rule = %Metadata{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "produces error for invalid char in key" do
    rule = %Metadata{}
    assert validate(rule, %{"k\\" => "v"}, %{}, []) |> length == 1
    assert validate(rule, %{"k\"" => "v"}, %{}, []) |> length == 1
  end

  test "produces error for too many pairs" do
    rule = %Metadata{}
    metadata = for i <- 1..21, into: %{} ,do: {"k" <> to_string(i), "blah"}
    assert validate(rule, metadata, %{}, []) |> length == 1
  end

  test "produces no errors for 20 pairs" do
    rule = %Metadata{}
    metadata = for i <- 1..20, into: %{} ,do: {"k" <> to_string(i), "blah"}
    assert validate(rule, metadata, %{}, []) == []
  end
end
