defmodule Lob.Validators.BankAccount do
  defstruct apply?: true, rule: &Lob.Schemas.BankAccount.schema/0
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.BankAccount do
  use Lob.Validators.Base
end
