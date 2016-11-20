defmodule Lob.Validators.Core.Path do
  alias Lob.Validators.Core.Str
  defstruct path: %Str{min: 1}, apply?: true

  def validate_path(errors, path) do
    {status, stats} = File.stat(path)
    exists = status == :ok
    readable = exists && stats.access in [:read, :read_write]
    case {exists, readable} do
      {true, false} -> ["Path: #{path} exists but is not readable" | errors]
      {true, true}  -> errors
      _             -> ["Path: #{path} does not exists" | errors]
    end
  end
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.Path do
  use Lob.Validators.Core.Apply
  alias Lob.Validators.Core.Validate
  alias Lob.Validators.Core.Path

  def validate(rule, val, data, errors) do
    rule.path
    |> Validate.validate(val, data, errors)
    |> Path.validate_path(val)
  end
end
