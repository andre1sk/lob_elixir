defmodule Lob.Validators.Core.URLTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.URL
  import Lob.Validators.Core.Validate

  test "can define url" do
    rule = %URL{}
    assert rule.__struct__ == URL
  end

  test "produces no errors for nil" do
    rule = %URL{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "valid https url produces no errors" do
    rule = %URL{}
    data = "https://wow.com"
    assert validate(rule, data, %{}, []) == []
  end

  test "valid http url produces no errors" do
    rule = %URL{}
    data = "http://wow.com"
    assert validate(rule, data, %{}, []) == []
  end

  test "invalid http url produces  errors" do
    rule = %URL{}
    data = "http//wow.com"
    assert validate(rule, data, %{}, []) |> length == 1
  end

  test "apply? is implemented" do
    assert  apply?(%URL{}, %{}) == true
  end

  test "apply? is flase if apply? func returns false" do
    rule = %URL{apply?: &(&1[:it] != :what)}
    assert  apply?(rule, %{it: :what}) == false
  end


end
