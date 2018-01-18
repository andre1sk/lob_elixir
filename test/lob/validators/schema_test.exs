defmodule Lob.Validators.SchemaTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Str
  alias Lob.Validators.Core.Req
  alias Lob.Validators.Schema

  test "produces no errors for empty schema" do
    assert Schema.validate(%{}, %{}) == %{}
  end

  test "produces no errors for simple valid input" do
    assert Schema.validate(%{k: [%Str{max: 10}]}, %{k: "lob"}) == %{}
  end

  test "produces error for simple invalid input" do
    %{k: errors} = Schema.validate(%{k: [%Str{max: 1}]}, %{k: "lob"})
    assert length(errors) == 1
  end

  test "produces error for missing required field" do
    res = Schema.validate(%{k: [%Str{max: 5}], z: [%Req{}]}, %{k: "lob"})
    assert res == %{z: ["value is required"]}
  end

  test "produces no errors for missing required field if apply is false" do
    res = Schema.validate(%{k: [%Str{max: 5}], z: [%Req{apply?: false}]}, %{k: "lob"})
    assert res == %{}
  end

  test "produces error for missing required field if apply is function evaluating to true" do
    res =
      Schema.validate(%{k: [%Str{max: 5}], z: [%Req{apply?: &Map.has_key?(&1, :k)}]}, %{k: "lob"})

    assert res == %{z: ["value is required"]}
  end

  test "produces no error for missing required field if apply is function evaluating to false" do
    res =
      Schema.validate(%{k: [%Str{max: 5}], z: [%Req{apply?: &(!Map.has_key?(&1, :k))}]}, %{
        k: "lob"
      })

    assert res == %{}
  end
end
