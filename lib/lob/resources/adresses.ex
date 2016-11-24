defmodule Lob.Resources.Addresses do
  @moduledoc """
  Functions for working with Addresses API endpoint
  """

  alias Lob.Schemas.Address
  use Lob.Resources.Base

  def name, do: "addresses"

  def schema, do: Address.schema()

end
