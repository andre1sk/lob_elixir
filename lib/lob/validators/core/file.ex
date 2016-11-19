defmodule Lob.Validators.Core.File do
  defstruct content: nil, path: nil, url: nil
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Map do
  use Lob.Validators.Core.Apply
  def validate(rule, val, data, errors) do
    errors
  end
end
