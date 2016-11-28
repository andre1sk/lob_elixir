defmodule Lob.Validators.Core.Bool do
  defstruct  apply?: true

end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Bool do
  use Lob.Validators.Core.Apply

  def validate(_, nil, _, errors) do
    errors
  end
  def validate(_, val, _, errors) when is_boolean(val) do
    errors
  end
  def validate(_, val, _, errors) do
    ["val must be a Boolean got #{inspect val} instead" | errors]
  end

end
