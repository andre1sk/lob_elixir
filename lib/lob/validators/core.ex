defprotocol Lob.Validators.Core.Validate do
  def validate(rule, val, data, errors)
end

defmodule Lob.Validators.Core.Str do
  defstruct min: 0, max: nil, when: nil, not: nil, regex: nil, exists_in: nil

  def validate_max(errors, val, max) do
    len = String.length(val)
    ok? = max == nil || len <= max
    ok? && errors || [ "#{len} is bigger than max allowed #{max}" | errors]
  end

  def validate_min(errors, val, min) do
    len = String.length(val)
    ok? = min == nil || len >= min
    ok? && errors || [ "#{len} is less than min allowed #{min}" | errors]
  end

end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Str do
  alias Lob.Validators.Core.Str

  def validate(rule, val, data, errors) when is_binary(val) do
    errors
    |> Str.validate_max(val, rule.max)
    |> Str.validate_min(val, rule.min)
  end
  def validate(_, val, _, errors) do
    ["val must be a string got #{inspect val} instead" | errors]
  end

end

defmodule Lob.Validators.Core.Map do
  defstruct min: 0, max: nil, when: nil, not: nil, key: nil, value: nil
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Map do
  def validate(rule, val, data, errors) do
    errors
  end
end

defmodule Lob.Validators.Core.File do
  defstruct content: nil, path: nil, url: nil
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Map do
  def validate(rule, val, data, errors) do
    errors
  end
end
