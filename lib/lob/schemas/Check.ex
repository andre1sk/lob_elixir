defmodule Lob.Schemas.Check do
  @moduledoc """
  Fuctions for Checkschema definition

  description: 	optional
to: 	required

Must either be an address ID or an object with correct address parameters. If an object is used, an address will be created for you and returned with an ID.
from: 	required
Must either be an address ID or an object with correct address parameters. If an object is used, an address will be created for you and returned with an ID.

bank_account: 	required
Must be a bank account ID. Only verified bank accounts may be used.

amount: 	required
The payment amount to be sent in dollars. Must be less than 1000000.

memo: 	optional
Max of 40 characters to be included on the memo line of the check.

check_number: 	optional
Checks will default starting at 10000 and increment accordingly.

logo: 	optional
This can be a URL or local file. The image must be a square, have color model of RGB or CMYK, be at least 100px X 100px, and have a transparent background. The accepted file types are PNG and JPEG. If supplied, the logo is printed in grayscale and placed in the upper-left corner of the check.

message: 	optional
Either message or check_bottom, choose one. Max of 400 characters to be included at the bottom of the check page.

check_bottom: 	optional
Either message or check_bottom, choose one. This can be a local file or a URL to a 1 page 8.5"x11" PDF, PNG, or JPEG, or an HTML string. This will be printed on the bottom of the check page in black & white. You must follow this template.

attachment: 	optional
A document to include with the check. This can be a local file or a URL to an 8.5"x11" PDF, PNG, or JPEG, or an HTML string. This will be printed double-sided in black & white and will be included in the envelope after the check page. If a PDF is provided, it must be 6 pages or fewer. If HTML is provided that renders to more than 6 pages, it will be trimmed. Please follow these design guidelines. See pricing for extra costs incurred.

data: 	optional
Must be an object with up to 40 key-value pairs. Keys must be at most 40 characters and values must be at most 500 characters. Neither can contain the characters " and \. Nested objects are not supported. For parameters that accept HTML strings, you can provide optional data variables that will be merged with your HTML. To add a variable, insert double curly braces into your HTML like so: {{variable_name}}.
mail_type: 	optional

A string designating the mail postage type. Options are usps_first_class or ups_next_day_air. Defaults to usps_first_class. See pricing for extra costs incurred for ups_next_day_air.
metadata: 	optional

Must be an object with up to 20 key-value pairs. Keys must at most 40 characters and values must be at most 500 characters. Neither can contain the characters " and \. Nested objects are not supported. See Metadata for more information.
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
      amount: [%Req{}, %FloatingPoint{min: 0.01, max: 1_000_000.0}],
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
