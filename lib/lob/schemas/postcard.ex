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

end
