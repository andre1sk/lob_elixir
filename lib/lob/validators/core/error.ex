defmodule Lob.Validators.Core.Error do
  defstruct  apply?: true, error: "error"

end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Error do
  use Lob.Validators.Core.Apply
  alias Lob.Validators.Core.Error

  def validate(rule, _, _, errors) do
    [rule.error | errors]
  end
end
