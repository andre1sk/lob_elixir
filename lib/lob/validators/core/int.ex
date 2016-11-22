defmodule Lob.Validators.Core.Int do
  defstruct min: nil, max: nil, apply?: true

  @spec validate_max(list, integer, integer | nil) :: list[String.t]
  def validate_max(errors, _, nil) do
    errors
  end
  def validate_max(errors, val, max) when is_integer(max) and val <= max do
    errors
  end
  def validate_max(errors, val, max) when is_integer(max) do
    ["#{val} is bigger than max allowed #{max}" | errors]
  end
  def validate_max(errors, val, max) do
    ["max needs to be an integer got max: #{inspect max} instead" | errors]
  end

  @spec validate_min(list, String.t, integer | nil) :: list[String.t]
  def validate_min(errors, _, nil) do
    errors
  end
  def validate_min(errors, val, min) when is_integer(min) and val >= min do
    errors
  end
  def validate_min(errors, val, min) when is_integer(min)  do
   ["#{val} is less than min allowed  #{min}" | errors]
  end
  def validate_min(errors, _, min) do
    ["min: expecting integer got #{inspect min} instead" | errors]
  end


end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Int do
  use Lob.Validators.Core.Apply
  alias Lob.Validators.Core.Int

  @spec validate(map, any, map, list[String.t]) :: list[String.t]
  def validate(_, nil, _, errors) do
    errors
  end
  def validate(rule, val, data, errors) when is_integer(val) do
    errors
    |> Int.validate_max(val, rule.max)
    |> Int.validate_min(val, rule.min)
  end
  def validate(_, val, _, errors) do
    ["val must be an integer got #{inspect val} instead" | errors]
  end

end
