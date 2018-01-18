defmodule Lob.Resources.Letters do
  @moduledoc """
  Functions for working with Letters API endpoint
  """

  alias Lob.Schemas.Letter
  use Lob.Resources.Base

  def name, do: "letters"

  def schema, do: Letter.schema()
end
