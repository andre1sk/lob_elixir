defmodule Lob.Resources.StatesTest do
  use ExUnit.Case, async: true
  import Lob.Test.Util
  alias Lob.Resources.States

  test "list states" do
    {status, res} = States.list(api_key())
    assert status == :ok
    assert res["AZ"] == "Arizona"
    assert res["VA"] == "Virginia"
  end
end
