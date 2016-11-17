defmodule Lob.Schemas.Address do
  use Lob.Schemas.Schema
  alias Lob.Data.Countries
  alias Lob.Data.States
  def schema do
    str200 = %Str{min: 1, max: 200}
  #  str100 = %Str{min: 1, max: 100}
  #  strm40 = %Str{max: 40}
  #  require_for_us = %Req{when: {address_country: "US"}}
  #  us_state = %Str{max: 2, min: 2, when: %{address_country: "US"}, exissts_in: States.data}
  #  other_state =%Str{max: 40, not: %{address_country: "US"}}
  #  %{
  #    description: [],
  #    name: %Str{max: 50},
  #    company: [str200, :name_or_co],
  #    address_line1: [%Req{}, str200],
  #    address_line2: str200,
  #    address_country: [%Str{max: 2, min: 2, default: "US", exissts_in: Countries.data}],
  #    address_city: [require_for_us, str200],
  #    address_state: [require_for_us, :state],
  #    address_zip: [require_for_us, {us_state, other_state}],
  #    phone: strm40,
  #    email: str100,
  #    metadata: %Map{key: %Str{max: 40, regex:}, value: , max: 20}
  #  }
  end

end
