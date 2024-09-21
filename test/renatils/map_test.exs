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
end
