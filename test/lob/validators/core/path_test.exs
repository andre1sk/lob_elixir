defmodule Lob.Validators.Core.PathTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.Path
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(Path)


  test "produces no errors for nil" do
    rule = %Path{}
    assert validate(rule, nil, %{}, []) == []
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

end
