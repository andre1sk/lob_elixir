defprotocol Lob.Validators.Core.Validate do
  @spec validate(%{atom => any}, any, any, any) :: any
  def validate(rule, val, data, errors)
  def apply?(rule, data)
end

defmodule Lob.Validators.Core.Apply do
  defmacro __using__(_params) do
    quote do
      @spec apply?(%{atom => any}, %{atom => any}) :: [String.t]
      def apply?(%{apply?: bool}, _) when is_boolean(bool) do
        bool
      end
      def apply?(%{apply?: fun}, data) when is_function(fun) do
        fun.(data)
      end
    end
  end
end
