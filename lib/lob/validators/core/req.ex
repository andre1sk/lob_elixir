defmodule Lob.Validators.Core.Req do
  defstruct apply?: true
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Req do
  use Lob.Validators.Core.Apply
  def validate(_, val, _, errors) do
    val != nil && errors || [ "value is required"| errors]
  end
end
