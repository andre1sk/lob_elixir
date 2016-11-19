defprotocol Lob.Validators.Core.Validate do
  def validate(rule, val, data, errors)
  def apply?(rule, data)
end

defmodule Lob.Validators.Core.Apply do
  defmacro __using__(_params) do
    quote do
      @spec apply?(%{atom => any}, %{atom => any}) :: [String.t]
      def apply?(%{apply?: true}, _) do
        true
      end
      def apply?(%{apply?: fun}, data) when is_function(fun) do
        fun.(data)
      end
    end
  end
end
