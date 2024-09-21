defmodule Renatils.JSONTest do
  use ExUnit.Case, async: true

  describe "encode!/1" do
    test "encodes the JSON input, as expected" do
      [
        {%{}, "{}"},
        {"", "\"\""},
        {%{foo: :bar}, "{\"foo\":\"bar\"}"},
        {%{foo: %{bar: %{baz: nil}}}, "{\"foo\":{\"bar\":{\"baz\":null}}}"},
        {[], "[]"},
        {[1, "2", true], "[1,\"2\",true]"},
        # Handles nil/null conversion correctly
        {nil, "null"},
        {[nil, 1, nil], "[null,1,null]"},
        # Misc / edge cases
        # Jason.encode also returns {"nil":1} for %{nil => 1} and {"true":1} for %{true => 1}
        # For now, I'm opting to follow the same behaviour as Jason.
        {%{nil => 1}, "{\"nil\":1}"},
        {%{true => 1}, "{\"true\":1}"}
      ]
      |> Enum.each(fn {input, output} ->
        assert Renatils.JSON.encode!(input) == output
      end)
    end
  end

  describe "decode!/1" do
    test "decodes the string input, as expected" do
      [
        {"{}", %{}},
        {"\"\"", ""},
        {"{\"foo\":\"bar\"}", %{"foo" => "bar"}},
        {"{\"foo\":{\"bar\":{\"baz\":null}}}", %{"foo" => %{"bar" => %{"baz" => nil}}}},
        {"[]", []},
        {"[1,\"2\",true]", [1, "2", true]},
        # Handles nil/null conversion correctly
        {"null", nil},
        {"[null,1,null]", [nil, 1, nil]},
        # Misc / edge cases
        # Jason.encode also returns {"nil":1} for %{nil => 1} and {"true":1} for %{true => 1}
        # For now, I'm opting to follow the same behaviour as Jason.
        {"{\"nil\":1}", %{"nil" => 1}},
        {"{\"true\":1}", %{"true" => 1}}
      ]
      |> Enum.each(fn {input, output} ->
        assert Renatils.JSON.decode!(input) == output
      end)
    end
  end
end
