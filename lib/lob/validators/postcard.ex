defmodule Lob.Validators.Postcard do
  defstruct apply?: true, rule: &Lob.Schemas.Postcard.schema/0
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Postcard do
  use Lob.Validators.Base
end
