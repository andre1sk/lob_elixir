defmodule Lob.Validators.Letter do
  defstruct apply?: true, rule: &Lob.Schemas.Letter.schema/0
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Letter do
  use Lob.Validators.Base
end
