defmodule Lob.Schemas.Schema do
  defmacro __using__(_params) do
    quote do
      import Lob.Validators.Core.Validate
      alias  Lob.Validators.Core.Str      
    end
  end
end
