defprotocol Lob.Validators.Core.Validate do
  def validate(rule, val, data, errors)
end

defmodule Lob.Validators.Core.Str do
  defstruct min: 0, max: nil, when: nil, not: nil, regex: nil, exists_in: nil

  def validate_max(errors, _, nil) do
    errors
  end
  def validate_max(errors, val, max) when is_integer(max) do
    len = String.length(val)
    ok? = max == nil || len <= max
    ok? && errors || [ "#{len} is bigger than max allowed #{max}" | errors]
  end
  def validate_max(errors, _, max) do
    ["max: expecting integer got #{inspect max} instead" | errors]
  end

  def validate_min(errors, _, nil) do
    errors
  end
  def validate_min(errors, val, min) when is_integer(min) do
    len = String.length(val)
    ok? = min == nil || len >= min
    ok? && errors || [ "#{len} is less than min allowed #{min}" | errors]
  end
  def validate_min(errors, _, min) do
    ["min: expecting integer got #{inspect min} instead" | errors]
  end

  def validate_regex(errors, _, nil) do
    errors
  end
  def validate_regex(errors, val, regex) do
    if Regex.regex?(regex) do
      ok? = Regex.match?(regex, val)
      ok? && errors || ["#{inspect val} did not match regex" | errors]
    else
      ["regex: expecting regex got #{inspect regex} instead" | errors]
    end
  end

end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Str do
  alias Lob.Validators.Core.Str

  def validate(rule, val, data, errors) when is_binary(val) do
    errors
    |> Str.validate_max(val, rule.max)
    |> Str.validate_min(val, rule.min)
    |> Str.validate_regex(val, rule.regex)
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
