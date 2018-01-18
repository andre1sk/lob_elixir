defmodule Lob.Validators.Check do
  defstruct apply?: true, rule: &Lob.Schemas.Check.schema/0
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Check do
  use Lob.Validators.Base
end
