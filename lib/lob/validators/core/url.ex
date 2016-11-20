defmodule Lob.Validators.Core.URL do
  alias Lob.Validators.Core.Str
  defstruct path: %Str{min: 1, regex: ~r/^(https|http){1}:\/\//}, apply?: true

end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.URL do
  use Lob.Validators.Core.Apply
  alias Lob.Validators.Core.Validate
  def validate(rule, val, data, errors) do
    Validate.validate(rule.path, val, data, errors)
  end
end
