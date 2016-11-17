defprotocol Lob.Validators.Core.Validate do
  def validate(rule, val, data, errors)
end

defmodule Lob.Validators.Core.Str do
  defstruct min: 0, max: nil, when: nil, not: nil, regex: nil, exists_in: nil
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Str do
  def validate(rule, val, data, errors) do
    errors
  end
end

defmodule Lob.Validators.Core.Map do
  defstruct min: 0, max: nil, when: nil, not: nil, key: nil, value: nil
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Map do
  def validate(rule, val, data, errors) do
    errors
  end
end

defmodule Lob.Validators.Core.File do
  defstruct content: nil, path: nil, url: nil
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Map do
  def validate(rule, val, data, errors) do
    errors
  end
end
