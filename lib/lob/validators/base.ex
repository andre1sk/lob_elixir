defmodule Lob.Validators.Base do
  defmacro __using__(_params) do
    quote do
      use Lob.Validators.Core.Apply
      alias Lob.Validators.Core.Validate

      def validate(_, nil, _, errors) do
        errors
      end

      def validate(rule, val, data, errors) do
        if is_function(rule.rule) do
          schema = rule.rule.()
          (apply?(rule, data) && Lob.Validators.Schema.validate(schema, val)) || errors
        else
          (apply?(rule, data) && Validate.validate(rule.rule, val, data, errors)) || errors
        end
      end
    end
  end
end
