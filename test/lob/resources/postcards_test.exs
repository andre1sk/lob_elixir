defmodule Lob.Resources.PostcardsTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Postcards
  alias Lob.Resources.Addresses
  import Lob.Test.Util

  test "list no params" do
    {status, _} = Postcards.list(api_key())
    assert status == :ok
  end

  test "list with limit" do
    {status, data} = Postcards.list(%{limit: 5},api_key())
    assert status == :ok
    assert data.body["count"] <= 5
  end

  test "list with total count" do
    {status, data} = Postcards.list(%{limit: 1, include: true}, api_key())
    assert Map.has_key?(data.body, "total_count")
    assert status == :ok
  end

  test "list with metadata" do
    {status, _} = Postcards.list(%{limit: 1, metadata: %{"k"=>"v"}}, api_key())
    assert status == :ok
  end

  test "list with date_created:" do
    {status, _} = Postcards.list(%{limit: 1, date_created: %{gt: "2016-11-19"}}, api_key())
    assert status == :ok
  end

  test "retrieve" do
    {_, data} = Postcards.list(%{limit: 1}, api_key())
    id = (data.body["data"] |> hd)["id"]
    {status, data} = Postcards.retrieve(id, api_key())
    assert status == :ok
    assert data.body["id"] == id
  end

  test "creates valid Postcard" do
    {_, data} = Addresses.list(%{limit: 1}, api_key())
    id = (data.body["data"] |> hd)["id"]
    postcard = %{
      to: id,
      front: %{path: "./test/fixtures/4x6_postcard.pdf", name: "front"},
      message: "Have fun!"
    }
    {status, data} = Postcards.create(postcard, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("psc_")
  end

  test "creates valid Postcard 2 files" do
    {_, data} = Addresses.list(%{limit: 1}, api_key())
    id = (data.body["data"] |> hd)["id"]
    postcard = %{
      to: id,
      front: %{path: "./test/fixtures/4x6_postcard.pdf", name: "front"},
      back: %{path: "./test/fixtures/4x6_postcard2.pdf", name: "back"},
    }
    {status, data} = Postcards.create(postcard, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("psc_")
  end

  test "error on invalid Postcard" do
    postcard = %{
      front: %{path: "./test/fixtures/4x6_postcard.pdf", name: "front"},
      back: %{path: "./test/fixtures/4x6_postcard2.pdf", name: "back"},
    }
    {status, data} = Postcards.create(postcard, api_key())
    assert status == :error
    assert data == %{to: ["value is required"]}
  end

end
