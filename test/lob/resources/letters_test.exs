defmodule Lob.Resources.LettersTest do
  use ExUnit.Case, async: true
  alias Lob.Resources.Letters
  alias Lob.Resources.Addresses
  import Lob.Test.Util
  require Lob.Tests.Shared

  Lob.Tests.Shared.resource(Letters)

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
    letter = %{
      to: "adr_xyz",
      from: "adr_xyz",
      color: true,
      file: %{path: "./test/fixtures/letter.pdf", name: "file"},
    }
    {status, _} = Letters.create(letter, api_key())
    assert status == :error
  end

end
