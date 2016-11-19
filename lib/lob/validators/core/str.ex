defmodule Lob.Validators.Core.Str do
  defstruct min: 0, max: nil, apply?: true, regex: nil, in: nil

  @spec validate_max(list, String.t, integer | nil) :: list[String.t]
  def validate_max(errors, _, nil) do
    errors
  end
  def validate_max(errors, val, max) when is_integer(max) do
    len = String.length(val)
    ok? = len <= max
    ok? && errors || [ "#{len} is bigger than max allowed #{max}" | errors]
  end
  def validate_max(errors, _, max) do
    ["max: expecting integer got #{inspect max} instead" | errors]
  end

  @spec validate_min(list, String.t, integer | nil) :: list[String.t]
  def validate_min(errors, _, nil) do
    errors
  end
  def validate_min(errors, val, min) when is_integer(min) do
    len = String.length(val)
    ok? = len >= min
    ok? && errors || [ "#{len} is less than min allowed #{min}" | errors]
  end
  def validate_min(errors, _, min) do
    ["min: expecting integer got #{inspect min} instead" | errors]
  end

  @spec validate_regex(list[String.t], String.t, Regex.t | nil) :: list[String.t]
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
  use Lob.Validators.Core.Apply
  alias Lob.Validators.Core.Str

  @spec validate(map, any, map, list[String.t]) :: list[String.t]
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
