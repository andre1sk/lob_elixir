defmodule Lob.Validators.Schema do
  alias Lob.Validators.Core.Validate


  def validate(schema, data) do
    ndata =
      Map.keys(schema)
      |> Enum.reduce(data, &(Map.has_key?(&2, &1) && &2 || Map.put(&2, &1, nil)))

    Enum.reduce(schema, %{},
      fn({k, v}, errors) ->
        key_errors = Enum.reduce(v, [],
          fn (rule, errors) ->
            Validate.apply?(rule, ndata) && Validate.validate(rule, ndata[k], ndata, errors) || errors
          end)
        no_errors? = key_errors == [] || key_errors == %{}
        no_errors? && errors || Map.put(errors, k, key_errors)
      end)
  end
end
