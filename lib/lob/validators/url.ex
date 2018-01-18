defmodule Lob.Validators.URL do
  alias Lob.Validators.Core.Str
  defstruct rule: %Str{min: 1, regex: ~r/^(https|http){1}:\/\//}, apply?: true
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.URL do
  use Lob.Validators.Base
end
