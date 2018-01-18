defmodule Lob.Schemas.Postcard do
  @moduledoc """
  Fuctions for Letter schema definition
  """
  use Lob.Schemas.Schema

  def schema do
    %{
      description: str(),
      to: address(:to),
      from: address(:from, false),
      front: req_file(),
      back: req_file(),
      data: data(),
      message: [msg_back(), %Str{max: 350}],
      size: str_in(["4x6", "6x9", "6x11"]),
      metadata: metadata()
    }
  end

  def msg_back do
    fun = &(&1[:back] == nil && &1[:messgae] == nil)
    %Req{apply?: fun, error: ":back or :messages is required"}
  end
end
