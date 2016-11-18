defmodule Lob.Validators.Core.ReqTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Req
  import Lob.Validators.Core.Validate

  test "can define Lob.Validators.Core.Req" do
    rule = %Req{}
    assert rule.__struct__ == Lob.Validators.Core.Req
  end

  test "produces no error if value is present" do
    rule = %Req{}
    res = validate(rule, "blah", %{}, [])
    assert res == []
  end

  test "produces error if value is not present" do
    rule = %Req{}
    res = validate(rule, nil, %{}, [])
    assert length(res) == 1
  end

  test "apply? is implemented" do
    assert  apply?(%Req{}, %{}) == true
  end

  test "apply? is flase if apply? func returns false" do
    rule = %Req{apply?: &(&1[:it] != :what)}
    assert  apply?(rule, %{it: :what}) == false
  end
end
