defmodule Lob.Validators.Core.URLTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.URL
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(URL)

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
end
