defmodule Lob.Resources.PostcardsTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Postcards
  alias Lob.Resources.Addresses
  import Lob.Test.Util
  require Lob.Tests.Shared

  setup_all do
    {_, data} = Addresses.list(%{limit: 1}, api_key())
    id = (data.body["data"] |> hd)["id"]
    {:ok, [addr_id: id]}
  end

  Lob.Tests.Shared.resource(Postcards)

  test "creates valid Postcard", context do
    postcard = %{
      to: context[:addr_id],
      front: %{path: "./test/fixtures/4x6_postcard.pdf", name: "front"},
      back: %{path: "./test/fixtures/4x6_postcard2.pdf", name: "back"}
    }

    {status, data} = Postcards.create(postcard, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("psc_")
  end

  test "error on invalid Postcard" do
    postcard = %{
      front: %{path: "./test/fixtures/4x6_postcard.pdf", name: "front"},
      back: %{path: "./test/fixtures/4x6_postcard2.pdf", name: "back"}
    }

    {status, data} = Postcards.create(postcard, api_key())
    assert status == :error
    assert data == {:validation, %{to: ["value is required"]}}
  end
end
