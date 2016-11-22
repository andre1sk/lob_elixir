defmodule Lob.Schemas.Schema do
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

      #TODO: move to a module
      def str do
        [%Str{}]
      end

      def str_in(data) do
        [%Str{in: data}]
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
    end
  end
end
