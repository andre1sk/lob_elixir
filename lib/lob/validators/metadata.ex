defmodule Lob.Validators.Metadata do
  alias Lob.Validators.Core.KV
  alias Lob.Validators.Core.Str

  defstruct rule: %KV{key: %Str{max: 40, regex: ~r/^[^"\\]*$/},
    value: %Str{min: 1, max: 500}, max: 20 }, apply?: true
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Metadata do
  use Lob.Validators.Base
end
