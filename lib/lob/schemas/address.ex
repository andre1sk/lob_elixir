defmodule Lob.Schemas.Address do
  use Lob.Schemas.Schema
  alias Lob.Data.Countries
  alias Lob.Data.States
  defstruct [description: nil, name: nil, company: nil, address_line1: nil,
    address_line2: nil, address_country: "US", address_city: nil,
    address_state: nil, address_zip: nil, phone: nil, email: nil, metadata: nil]


  def schema do
    str200 = %Str{min: 1, max: 200}
    str100 = %Str{min: 1, max: 100}
    strm40 = %Str{max: 40}
    us? = fn(data) -> data[:address_country] == "US" end
    #require_for_us = %Req{apply?: us?}
    #us_state = %Str{max: 2, min: 2, apply?: us?, in: States.data}
    #name_or_co? = &(Map.has_key?(&1, :name) || Map.has_key?(&1, :company))
    #name_or_co = %Req{apply?: name_or_co?}
    #not_us? = &(&1[:address_country] != "US")
    #other_state =%Str{max: 40, apply?: not_us?}
    #%Address{
    #  description: [],
    #  name: %Str{max: 50},
    #  company: [str200, name_or_co],
    #  address_line1: [%Req{}, str200],
    #  address_line2: str200,
    #  address_country: [%Str{max: 2, min: 2, default: "US", exissts_in: Countries.data}],
    #  address_city: [require_for_us, str200],
    #  address_state: [require_for_us, :state],
    #  address_zip: [require_for_us, us_state, other_state],
    #  phone: strm40,
    #  email: str100,
    #  metadata: %Map{key: %Str{max: 40, regex:}, value: , max: 20}
   #}
  end


end
