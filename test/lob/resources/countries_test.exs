defmodule Lob.Resources.CountriesTest do
  use ExUnit.Case, async: true
  import Lob.Test.Util
  alias Lob.Resources.Countries

  test "list countries" do
    {status, res} = Countries.list(api_key())
    assert status == :ok
    assert res["UA"] == "Ukraine"
    assert res["US"] == "United States"
    assert res["AD"] == "Andorra"
  end
end
