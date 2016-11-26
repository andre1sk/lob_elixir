defmodule Lob.Validators.Core.KVTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.KV
  alias Lob.Validators.Core.Str
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(KV)

  test "produces no errors for nil" do
    rule = %KV{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "key that viloates rule raises error" do
    rule = %KV{key: %Str{max: 2}}
    assert validate(rule,%{"abc" => "z"},%{}, []) != []
  end

  test "valid key does not raise error" do
    rule = %KV{key: %Str{max: 3}}
    assert validate(rule,%{"abc" => "z"},%{}, []) == []
  end

  test "valid value does not raise error" do
    rule = %KV{value: %Str{min: 3}}
    assert validate(rule,%{"abc" => "zoom"},%{}, []) == []
  end

  test "invalid value does raise error" do
    rule = %KV{value: %Str{min: 3}}
    assert validate(rule,%{"abc" => "zo"},%{}, []) |> length == 1
  end

  test "invalid key and value result in errors" do
    rule = %KV{key: %Str{max: 3}, value: %Str{min: 3}}
    assert validate(rule,%{"abcd" => "zo"},%{}, []) |> length == 2
  end

  test "mix of valid and invalid kvs produces correct number of erros" do
    rule = %KV{key: %Str{max: 3}, value: %Str{min: 3}}
    data = %{"abcd" => "zo", "abc" => "zoooom"}
    assert validate(rule, data, %{}, []) |> length == 2
  end

  test "all valid keys and values produce no errors" do
    rule = %KV{key: %Str{max: 3}, value: %Str{min: 3}}
    data = %{"zzz" => "boom", "abc" => "zoooom"}
    assert validate(rule, data, %{}, []) == []
  end

  test "number of kv pairs bigger then max produces error" do
    rule = %KV{key: %Str{max: 10}, value: %Str{max: 10}, max: 1}
    data = %{"zzz" => "boom", "abc" => "zoooom"}
    assert validate(rule, data, %{}, []) |> length == 1
  end

  test "number of kv pairs == max produces no errors" do
    rule = %KV{key: %Str{max: 10}, value: %Str{max: 10}, max: 2}
    data = %{"zzz" => "boom", "abc" => "zoooom"}
    assert validate(rule, data, %{}, []) == []
  end

end
