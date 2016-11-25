defmodule Lob.Schemas.Schema do
  @moduledoc """
  Functions for schema definition
  """

  defmacro __using__(_params) do
    quote do
      import Lob.Validators.Core.Validate
      alias Lob.Validators.Core.Str
      alias Lob.Validators.Core.Req
      alias Lob.Validators.Core.KV
      alias Lob.Validators.Metadata
      alias Lob.Validators.Data
      alias Lob.Validators.Core.File
      alias Lob.Validators.Address
      alias Lob.Validators.Core.Bool
      alias Lob.Validators.Core.Int

      def str do
        [%Str{}]
      end

      def req_str do
        [%Req{}, %Str{}]
      end

      def str_in(data) do
        [%Str{in: data}]
      end

      def req_str_in(data) do
        [%Req{}, %Str{in: data}]
      end

      def bool do
        [%Bool{}]
      end

      def req_bool do
        [%Req{}, %Bool{}]
      end

      def req_file do
        [%Req{}, %File{}]
      end

      def file do
        [%File{}]
      end

      def data do
        [%Data{}]
      end

      def metadata do
        [%Metadata{}]
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
  end
end
