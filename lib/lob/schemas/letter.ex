defmodule Lob.Schemas.Letter do
use Lob.Schemas.Schema

  def schema do
    %{
      description: str,
      to: address(:to),
      from: address(:from),
      color: req_bool,
      file: req_file,
      data: data,
      double_sided: bool,
      address_placement: str_in(["top_first_page", "insert_blank_page"]),
      return_envelope: bool,
      perforated_page: [%Req{apply?: &(&1[:return_envelope]==true)}, %Int{min: 1}],
      extra_service: str_in(["certified", "registered"]),
      metadata: metadata
    }
  end

end
