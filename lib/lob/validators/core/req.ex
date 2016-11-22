defmodule Lob.Validators.Core.Req do
  defstruct apply?: true, error: "value is required"
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Req do
  use Lob.Validators.Core.Apply
  def validate(rule, val, _, errors) do
    val != nil && errors || [rule.error | errors]
  end
end
