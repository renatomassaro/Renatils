defmodule Renatils.MapTest do
  use ExUnit.Case, async: true

  describe "atomify_keys/2" do
    test "atomifies the keys, as expected" do
      [
        {%{}, %{}},
        {%{"foo" => "bar"}, %{foo: "bar"}},
        {%{foo: :bar}, %{foo: :bar}},
        {%{"foo" => %{"bar" => %{"baz" => :woot}}}, %{foo: %{bar: %{baz: :woot}}}},
        {%{"foo" => %{bar: %{"baz" => nil}}}, %{foo: %{bar: %{baz: nil}}}},
        {%{1 => %{nil => %{{1, 2, "3"} => true}}}, %{1 => %{nil => %{{1, 2, "3"} => true}}}}
      ]
      |> Enum.each(fn {input, output} ->
        assert Renatils.Map.atomify_keys(input) == output
      end)
    end

    test "with the `with_existing_atom` flag" do
      # Crashes if given atom does not exist
      %{message: error} =
        assert_raise ArgumentError, fn ->
          Renatils.Map.atomify_keys(%{"ksjcdvq" => :bar}, with_existing_atom: true)
        end

      assert error =~ "not an already existing atom"

      # But works just fine if it does exist. The pattern match registers the atom
      assert %{kxqu: :bar} == Renatils.Map.atomify_keys(%{"kxqu" => :bar}, with_existing_atom: true)
    end
  end

  describe "safe_atomify_keys/1" do
    test "applies the `with_existing_atom` flag" do
      # Crashes if given atom does not exist
      %{message: error} =
        assert_raise ArgumentError, fn ->
          Renatils.Map.safe_atomify_keys(%{"zsjcdvq" => :bar})
        end

      assert error =~ "not an already existing atom"

      # But works just fine if it does exist. The pattern match registers the atom
      assert %{kxqix: :bar} == Renatils.Map.safe_atomify_keys(%{"kxqix" => :bar})
    end
  end

  describe "stringify_keys/1" do
    test "stringfies the keys, as expected" do
      [
        {%{}, %{}},
        {%{foo: :bar}, %{"foo" => :bar}},
        {%{foo: %{bar: %{baz: {:wo, "ot"}}}}, %{"foo" => %{"bar" => %{"baz" => {:wo, "ot"}}}}},
        {%{foo: %{"bar" => %{baz: true}}}, %{"foo" => %{"bar" => %{"baz" => true}}}},
        {%{1 => :numbers_get_stringified}, %{"1" => :numbers_get_stringified}},
        {%{true => :bool_doesnt_get_stringfied}, %{true => :bool_doesnt_get_stringfied}},
        {%{nil => :null_doesnt_get_stringfied}, %{nil => :null_doesnt_get_stringfied}},
        {%{{1, "2", nil} => []}, %{{1, "2", nil} => []}}
      ]
      |> Enum.each(fn {input, output} ->
        assert Renatils.Map.stringify_keys(input) == output
      end)
    end
  end

  describe "merge_if/3" do
    test "merges both maps if condition is true" do
      assert %{a: 1, b: 2} == Renatils.Map.merge_if(%{a: 1}, %{b: 2}, true)
      assert %{a: 2, b: 3} == Renatils.Map.merge_if(%{a: 1}, %{a: 2, b: 3}, true)
    end

    test "performs a no-op if condition is false" do
      assert %{a: 1} == Renatils.Map.merge_if(%{a: 1}, %{b: 2}, false)
    end
  end

  describe "destructify/1" do
    test "destructifies a struct" do
      # Let's use DateTime as example struct
      dt = DateTime.utc_now()
      assert is_struct(dt)

      # It's converted to map, identical to `Map.from_struct/1`
      assert Map.from_struct(dt) == Renatils.Map.destructify(dt)
    end

    test "recursively destructifies a struct" do
      dt = DateTime.utc_now()

      # At first we have a nested map, with `now.is.the.time` being a struct
      nested_map = %{now: %{is: %{the: %{time: dt}}}}
      assert is_struct(nested_map.now.is.the.time)

      # Now we have a new map. where `now.is.the.time` is a map
      new_map = Renatils.Map.destructify(nested_map)
      refute is_struct(new_map.now.is.the.time)
      assert is_map(new_map.now.is.the.time)

      # As a second example, we now have nested structs
      nested_struct =
        URI.new!("foo")
        |> Map.put(:host, URI.new!("bar"))

      # Both structs were destructified
      new_map = Renatils.Map.destructify(nested_struct)
      assert %{path: "foo", host: %{path: "bar"}} = new_map
      refute is_struct(new_map)
      refute is_struct(new_map.host)
    end

    test "destructifies a struct that is a map key" do
      # Did you know structs can be a map *key*?
      dt = DateTime.utc_now()
      map = %{dt => :now}

      # Initially, the map's only key is a struct
      [key] = Map.keys(map)
      assert is_struct(key)

      # Once it's been destructified, now the map's only key is a map
      new_map = Renatils.Map.destructify(map)
      [new_key] = Map.keys(new_map)
      refute is_struct(new_key)
      assert is_map(new_key)
    end

    test "performs a no-op on regular maps and values" do
      [
        %{foo: :bar},
        %{"abc" => %{xyz: 123}},
        -50,
        "foo",
        false,
        1.0
      ]
      |> Enum.each(fn value ->
        # Non-struct values remain unchanged
        assert value == Renatils.Map.destructify(value)
      end)
    end
  end
end
