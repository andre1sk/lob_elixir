defmodule Lob.Schemas.Check do
  @moduledoc """
  Fuctions for Check schema definition
  """

  use Lob.Schemas.Schema

  def schema do
    msg_or_chk_bot = &(&1[:message] != nil && &1[:check_bottom] != nil)
    error_msg = "Either message or check_bottom, choose one"
    error = %Error{apply?: msg_or_chk_bot, error: error_msg}
    %{
      description: str,
      to: address(:to),
      from: address(:from),
      bank_account: [%Req{}, %Str{regex: ~r/^bank_.+/}],
      amount: [%Req{}, %FloatingPoint{min: 0.01, max: 999_999.99}],
      memo: [%Str{max: 40}],
      check_number: int,
      logo: file, #TODO: validation of valid file type
      message: [%Str{max: 400}, error],
      check_bottom: [%File{}, error],
      attachment: file,
      data: data,
      mail_type: str_in(["usps_first_class","ups_next_day_air"]),
      metadata: metadata
    }
  end

end
