defmodule Lob.Resources.LettersTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Letters
  alias Lob.Resources.Addresses
  import Lob.Test.Util

  test "list no params" do
    {status, _} = Letters.list(api_key())
    assert status == :ok
  end

  test "list with limit" do
    {status, data} = Letters.list(%{limit: 5},api_key())
    assert status == :ok
    assert data.body["count"] <= 5
  end

  test "list with total count" do
    {status, data} = Letters.list(%{limit: 1, include: true}, api_key())
    assert Map.has_key?(data.body, "total_count")
    assert status == :ok
  end

  test "list with metadata" do
    {status, _} = Letters.list(%{limit: 1, metadata: %{"k"=>"v"}}, api_key())
    assert status == :ok
  end

  test "list with date_created:" do
    {status, _} = Letters.list(%{limit: 1, date_created: %{gt: "2016-11-19"}}, api_key())
    assert status == :ok
  end

  test "retrieve" do
    {_, data} = Letters.list(%{limit: 1}, api_key())
    id = (data.body["data"] |> hd)["id"]
    {status, data} = Letters.retrieve(id, api_key())
    assert status == :ok
    assert data.body["id"] == id
  end

  test "create valid letter" do
    {_, data} = Addresses.list(%{limit: 1}, api_key())
    id = (data.body["data"] |> hd)["id"]
    letter = %{
      to: id,
      from: id,
      color: true,
      file: %{path: "./test/fixtures/letter.pdf", name: "file"},
    }
    {status, data} = Letters.create(letter, api_key())
    assert status == :ok
    assert data.body["id"] |> String.starts_with?("ltr_")
  end

  test "create invalid letter produces error" do

  end



end
