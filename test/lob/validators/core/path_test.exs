defmodule Lob.Validators.Core.PathTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Path
  import Lob.Validators.Core.Validate

  test "can define Path" do
    rule = %Path{}
    assert rule.__struct__ == Path
  end

  test "valid path produces no errors" do
    rule = %Path{}
    path = "./test/fixtures/letter.pdf"
    assert validate(rule, path, %{}, []) == []
  end

  test "invalid path produces errors" do
    rule = %Path{}
    path = "./test/fixtures/letterz.pdf"
    assert validate(rule, path, %{}, []) |> length == 1
  end

  test "apply? is implemented" do
    assert  apply?(%Path{}, %{}) == true
  end

  test "apply? is flase if apply? func returns false" do
    rule = %Path{apply?: &(&1[:it] != :what)}
    assert  apply?(rule, %{it: :what}) == false
  end

end
