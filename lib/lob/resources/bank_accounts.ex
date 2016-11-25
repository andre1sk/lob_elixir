defmodule Lob.Resources.BankAccounts do
  @moduledoc """
  Functions for working with Postcards API endpoint
  """

  alias Lob.Schemas.BankAccount
  alias Lob.Client
  use Lob.Resources.Base

  def name, do: "bank_accounts"

  def schema, do: BankAccount.schema()

  def verify(id, d1, d2, api_key)
      when is_integer(d1) and d1 > 0 and d1 < 101 and
           is_integer(d2) and d2 > 0 and d2 < 101 do
    case id_uri(id) do
      {:ok, uri} -> Client.get(uri <> "/verify/?amounts[]=#{d1}amounts[]=#{d2}", api_key)
      {:error, error} -> {:error, error}
    end
  end
  def verify(_,_), do: {:error, "deposits need to be ints between 1 and 100"}

  def delete(id, api_key) do
    case id_uri(id) do
      {:ok, uri} -> Client.delete(id_uri(id), api_key)
      {:error, error} -> {:error, error}
    end
  end

  defp id_uri(id) when is_binary(id) do
    enc_id = URI.encode_www_form(id)
    {:ok, Lob.Resources.Base.base_uri() <> name() <>"/"<> enc_id}
  end
  defp id_uri(id), do: {:error, "expecting string got #{inspect id} instead"}

end
