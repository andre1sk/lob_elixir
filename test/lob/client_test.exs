defmodule Lob.ClientTest do
  alias Lob.Client
  use ExUnit.Case, async: true

  test "get works" do
    {status, data} = Client.get("http://httpbin.org/get", "haha")
    assert status == :ok
    assert data.status == 200
    assert data.body["headers"]["Authorization"] == "Basic aGFoYTo="
  end

  test "delete works" do
    {status, data} = Client.delete("http://httpbin.org/delete", "haha")
    assert status == :ok
    assert data.status == 200
    assert data.body["headers"]["Authorization"] == "Basic aGFoYTo="
  end

  test "post works" do
    {status, data} = Client.post("http://httpbin.org/post", [{"field", "field value"}], "haha")
    assert status == :ok
    assert data.status == 200
    assert data.body["headers"]["Authorization"] == "Basic aGFoYTo="
  end
end
