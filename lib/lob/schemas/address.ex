defmodule Lob.Schemas.Address do
  @moduledoc """
  Fuctions for Address schema definition
  """

  use Lob.Schemas.Schema
  alias Lob.Data.Countries
  alias Lob.Data.States

  def schema do
    str200 = %Str{min: 1, max: 200}
    us? = &(&1[:address_country] == "US")
    req_for_us = %Req{apply?: us?}
    us_state = %Str{max: 2, min: 2, apply?: us?, in: States.data()}
    not_us? = &(&1[:address_country] != "US")
    other_state = %Str{max: 40, apply?: not_us?}
    us_zip = %Str{apply?: us?, regex: ~r/\d{5}(-\d{4}){0,1}/}
    other_zip = %Str{apply?: not_us?, max: 40}

    %{
      description: str(),
      name: name_co(50),
      company: name_co(50),
      address_line1: [%Req{}, str200],
      address_line2: [str200],
      address_country: str_in(Countries.data()),
      address_city: [req_for_us, str200],
      address_state: [req_for_us, us_state, other_state],
      address_zip: [req_for_us, us_zip, other_zip],
      phone: [%Str{min: 1, max: 40}],
      email: [%Str{min: 1, max: 100}],
      metadata: metadata()
    }
  end

  def name_co(len) do
    fun = &(&1[:name] == nil && &1[:company] == nil)
    rule = %Req{apply?: fun, error: ":name or :company is required"}
    [%Str{min: 1, max: len}, rule]
  end
end
