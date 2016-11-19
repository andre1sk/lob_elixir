defmodule Lob.Validators.Core.KV do
  import Lob.Validators.Core.Validate
  defstruct min: 0, max: nil, apply?: true, key: nil, value: nil

  def validate_item({k, v}, errors, rule, data) do
    errors
    |>validate_kv(k, rule.key, data)
    |>validate_kv(v, rule.value, data)
  end

  def validate_kv(errors, _, nil, _) do
    errors
  end
  def validate_kv(errors, val, rule, data) do
    validate(rule, val, data, errors)
  end

  def validate_max(errors, nil, _) do
    errors
  end
  def validate_max(errors, val, max) do
    len = Map.keys(val) |> length
  end
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.KV do
  use Lob.Validators.Core.Apply
  alias Lob.Validators.Core.KV

  def validate(rule, val, data, errors) do
    val
    |>Enum.reduce(errors, &KV.validate_item(&1, &2, rule, val))
  end

end
