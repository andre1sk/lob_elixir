defmodule Lob.Resources.Checks do
  @moduledoc """
  Functions for working with Checks API endpoint
  """

  alias Lob.Schemas.Check
  use Lob.Resources.Base

  def name, do: "checks"

  def schema, do: Check.schema()
end
