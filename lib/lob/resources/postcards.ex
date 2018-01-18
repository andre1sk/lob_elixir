defmodule Lob.Resources.Postcards do
  @moduledoc """
  Functions for working with Postcards API endpoint
  """

  alias Lob.Schemas.Postcard
  use Lob.Resources.Base

  def name, do: "postcards"

  def schema, do: Postcard.schema()
end
