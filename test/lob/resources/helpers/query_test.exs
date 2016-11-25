defmodule Lob.Resources.Helpers.QueryTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Helpers.Query

  test "query" do
    data = %{
      name: "John Doe",
      address_country: "US",
    }
    res = Query.encode(data)
    assert res == "?&address_country=US&name=John+Doe"
  end

end
