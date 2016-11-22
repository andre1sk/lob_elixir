defmodule Lob.Schemas.Postcard do
use Lob.Schemas.Schema

  def schema do
    %{
      description: str,
      to: address(:to),
      from: address(:from, false),
      front: req_file,
      back: file,
      data: data,
      message: [%Str{max: 350}],
      size: str_in(["4x6", "6x9", "6x11"]),
      metadata: metadata
    }
  end

  def address(field, req \\true) do
    rule =
      [
        %Address{apply?: &(is_map(&1[field]))},
        %Str{min: 1, max: 100, regex: ~r/adr_/, apply?: &(is_binary(&1[field]))}
      ]
    req && [%Req{} | rule] || rule
  end
end
