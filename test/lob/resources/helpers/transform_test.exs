defmodule Lob.Resources.Helpers.TransformTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Helpers.Transform

  test "unnested transform" do
    data = %{
      name: "John Doe",
      address_country: "US",
    }
    {status, res} = Transform.transform(data)
    assert status == :ok
    assert res.data == [{"name", "John Doe"}, {"address_country", "US"}]
  end

  test "nested transform" do
    data = %{
      field1: "field1  value",
      field2: "field2  value",
      field3: %{nested1: "nested1 value", nested2: "nested2 value"},
      field4: "field4 value"
    }
    {status, res} = Transform.transform(data)
    assert status == :ok
    assert res.data == [
      {"field4", "field4 value"},
      {"field2", "field2  value"},
      {"field1", "field1  value"},
      {"field3[nested1]", "nested1 value"},
      {"field3[nested2]", "nested2 value"}
    ]
  end

  test "file" do
    data = %{
      some_file: %{path: "/go/file", name: "file"},
    }
    {status, res} = Transform.transform(data)
    assert status == :ok
    assert res.data == [{:file, "/go/file", {["form-data"], [name: "file", filename: "\"/go/file\""]}, []}]
    assert res.type == :multipart
  end

end
