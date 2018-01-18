defmodule Lob.Validators.Address do
  defstruct apply?: true, rule: &Lob.Schemas.Address.schema/0
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Address do
  use Lob.Validators.Base
end
