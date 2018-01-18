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
      when is_integer(d1) and d1 > 0 and d1 < 101 and is_integer(d2) and d2 > 0 and d2 < 101 do
    case id_uri(id) do
      {:ok, uri} -> Client.post(uri <> "/verify", [{"amounts[]", d1}, {"amounts[]", d2}], api_key)
      {:error, error} -> {:error, {:encoding, error}}
    end
  end

  def verify(_, _), do: {:error, {:validation, "deposits need to be ints between 1 and 100"}}

  def delete(id, api_key) do
    case id_uri(id) do
      {:ok, uri} -> Client.delete(uri, api_key)
      {:error, error} -> {:error, {:encoding, error}}
    end
  end
end
