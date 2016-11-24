defmodule Lob.ClientTest do
  alias Lob.Client
  use ExUnit.Case, async: true

  test "get works" do
    {status, data} = Client.get("http://httpbin.org/get", "haha")
    assert status == :ok
    assert data.status == 200
    assert data.body["headers"]["Authorization"] == "Basic aGFoYTo="
  end
end
