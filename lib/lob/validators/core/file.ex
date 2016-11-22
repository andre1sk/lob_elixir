defmodule Lob.Validators.Core.File do
  alias Lob.Validators.Core.Str
  alias Lob.Validators.Core.Path
  alias Lob.Validators.URL
  import Lob.Validators.Core.Validate

  defstruct name: %Str{min: 1}, content: %Str{min: 10}, path: %Path{}, url: %URL{}, apply?: true

  def validate_only_one(errors, val) do
    has =
      [:content, :path, :url]
      |> Enum.reduce(0, &(Map.has_key?(val, &1) && &2+1 || &2))

    has == 1 && errors || ["Exectly one of :content, :path, :url must be set"| errors]
  end

  def validate_name(errors, rule, val, data) do
    if Map.has_key?(val, :name) do
      validate(rule, val.name, data, errors)
    else
      [":name is required if :path is set" | errors]
    end
  end
end

defimpl Lob.Validators.Core.Validate, for: Lob.Validators.Core.File do
  use Lob.Validators.Core.Apply
  alias Lob.Validators.Core.File
  alias Lob.Validators.Core.Validate

  def validate(_, nil, _, errors) do
    errors
  end
  def validate(rule, val, data, errors) do
    only_one_errors = File.validate_only_one(errors, val)
    if only_one_errors == [] do
      key =
        [:content, :path, :url]
        |> Enum.reduce(nil, &(Map.has_key?(val, &1) && &1 || &2))
      v_errors= Validate.validate(Map.get(rule, key) , val[key], data, errors)
      key == :path && File.validate_name(v_errors, rule.name, val, data) || v_errors
    else
      only_one_errors
    end
  end
end
