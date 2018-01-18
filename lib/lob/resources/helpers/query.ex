defmodule Lob.Resources.Helpers.Query do
  @moduledoc """
  Helper functions for encoding list options as url query.
  """

  def encode(input) do
    input
    |> Enum.reduce([], &encode_item/2)
    |> Enum.reverse()
    |> prefix
    |> Enum.join("&")
  end

  def prefix([]), do: []
  def prefix(qlist), do: ["?" | qlist]

  def encode_item({:date_created, value}, acc) when is_map(value) do
    encoded = Poison.encode!(value) |> URI.encode_www_form()
    ["date_created=" <> encoded | acc]
  end

  def encode_item({:include, true}, acc) do
    ["include[]=total_count" | acc]
  end

  def encode_item({:metadata, value}, acc) do
    value
    |> Enum.reduce(acc, fn {k, v}, acc ->
      encode_item({"metadata[" <> k <> "]", v}, acc)
    end)
  end

  def encode_item({key, value}, acc) do
    item = to_string(key) <> "=" <> URI.encode_www_form(to_string(value))
    [item | acc]
  end
end
