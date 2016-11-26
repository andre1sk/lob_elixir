ExUnit.start()

defmodule Lob.Test.Util do
  def api_key do
   "test_0dc8d51e0acffcb1880e0f19c79b2f5b0cc" #public test key
  end
end

defmodule Lob.Tests.Shared do

  defmacro validator(s) do
    quote do
      test "can define" do
        rule=struct(unquote(s))
        assert rule.__struct__== unquote(s)
      end

      test "apply? is implemented" do
        assert  apply?(struct(unquote(s)), %{}) == true
      end

      test "apply? is flase if apply? func returns false" do
        rule = struct(unquote(s), [apply?: &(&1[:it] != :what)])
        assert  apply?(rule, %{it: :what}) == false
      end
    end
  end

  defmacro schema_meta(s) do
    quote do
      test "valid metadata produces no errors" do
        res = validate(struct(unquote(s)), %{metadata: %{"k"=>"v"}}, %{}, %{})
        refute Map.has_key?(res, :metadata)
      end

      test "invalid metadata produces an error" do
        res = validate(struct(unquote(s)), %{metadata: %{"k\\"=>"v"}}, %{}, %{})
        assert Map.has_key?(res, :metadata)
      end
    end
  end

  defmacro resource(r) do
    quote do

      test "retrieve" do
        {_, data} = unquote(r).list(%{limit: 1}, api_key())
        id = (data.body["data"] |> hd)["id"]
        {status, data} = unquote(r).retrieve(id, api_key())
        assert status == :ok
        assert data.body["id"] == id
      end

      test "list no params" do
        {status, _} = unquote(r).list(api_key())
        assert status == :ok
      end

      test "list with limit" do
        {status, data} = unquote(r).list(%{limit: 5},api_key())
        assert status == :ok
        assert data.body["count"] <= 5
      end

      test "list with total count" do
        {status, data} = unquote(r).list(%{limit: 1, include: true}, api_key())
        assert Map.has_key?(data.body, "total_count")
        assert status == :ok
      end

      test "list with metadata" do
        {status, _} = unquote(r).list(%{limit: 1, metadata: %{"k"=>"v"}}, api_key())
        assert status == :ok
      end

      test "list with date_created:" do
        {status, _} = unquote(r).list(%{limit: 1, date_created: %{gt: "2016-11-19"}}, api_key())
        assert status == :ok
      end
    end
  end


end
