defmodule Lob.Schemas.BankAccount do
  @moduledoc """
  Fuctions for Letter schema definition
  """

  use Lob.Schemas.Schema

  def schema do
    %{
      description: str,
      routing_number: [%Req{}, %Str{min: 9, max: 9}],
      account_number: req_str,
      account_type: req_str_in(["company", "individual"]),
      signatory: req_str,
      metadata: metadata
    }
  end

end
