defmodule Lob.Validators.Core.FloatingPoint do
  defstruct min: nil, max: nil, apply?: true

  @spec validate_max(list, float, float | nil) :: list[String.t()]
  def validate_max(errors, _, nil) do
    errors
  end

  def validate_max(errors, val, max) when is_float(max) and val <= max do
    errors
  end

  def validate_max(errors, val, max) when is_float(max) do
    ["#{val} is bigger than max allowed #{max}" | errors]
  end

  def validate_max(errors, _, max) do
    ["max needs to be a float got max: #{inspect(max)} instead" | errors]
  end

  @spec validate_min(list, String.t(), float | nil) :: list[String.t()]
  def validate_min(errors, _, nil) do
    errors
  end

  def validate_min(errors, val, min) when is_float(min) and val >= min do
    errors
  end

  def validate_min(errors, val, min) when is_float(min) do
    ["#{val} is less than min allowed  #{min}" | errors]
  end

  def validate_min(errors, _, min) do
    ["min: expecting float got #{inspect(min)} instead" | errors]
  end
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.FloatingPoint do
  use Lob.Validators.Core.Apply
  alias Lob.Validators.Core.FloatingPoint

  @spec validate(map, any, map, list[String.t()]) :: list[String.t()]
  def validate(_, nil, _, errors) do
    errors
  end

  def validate(rule, val, _, errors) when is_float(val) do
    errors
    |> FloatingPoint.validate_max(val, rule.max)
    |> FloatingPoint.validate_min(val, rule.min)
  end

  def validate(_, val, _, errors) do
    ["val must be a float got #{inspect(val)} instead" | errors]
  end
end
