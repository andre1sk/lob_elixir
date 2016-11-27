defmodule Lob.Resources.Helpers.Transform do
  @moduledoc """
  Helper functions for encoding a map into format acceptable for HTTPoision
  for form POST.
  """

  def transform(map, parent \\"") do
      try do
        res =
          map
          |> Enum.map(&(transform_item(&1, parent)))
          |> Enum.reduce([],&flatten/2)
        type = Enum.any?(res, &(elem(&1,0) == :file)) && :multipart || :form
        {:ok, %{data: res, type: type}}
      rescue
         _ -> {:error, "failed to transform data"}
      end
    end

    defp flatten(input, acc) when is_list(input) do
      acc ++ input
    end
    defp flatten(input, acc) do
      [input | acc ]
    end

    defp transform_item({_, %{path: path, name: name}}, _) do
      #  {:file, "/etc/hosts", {["form-data"], [name: "\"hosts\"", filename: "\"/etc/hosts\""]},[]}
      file_name = "\"" <> path <> "\""
      extra = {["form-data"], [name: name, filename: file_name]}
      {:file, path, extra, []}
    end
    defp transform_item({k, %{content: content}}, "") do
        {to_string(k), content}
    end
    defp transform_item({k, %{url: url}}, "") do
        {to_string(k), url}
    end
    defp transform_item({k,v}, _) when is_map(v) do
      {:ok, res} = transform(v, to_string(k))
      Enum.reverse(res.data)
    end
    defp transform_item({k, v}, "") when is_atom(v) do
      {to_string(k), to_string(v)}
    end
    defp transform_item({k,v}, "") do
        {to_string(k), to_string(v)}
    end
    defp transform_item({k,v}, parent) do
        {parent <> "[" <> to_string(k) <> "]", v}
    end

end
