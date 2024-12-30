defmodule Renatils.IPTest do
  use ExUnit.Case, async: true
  alias Renatils.IP

  describe "valid?/1" do
    test "returns expected results" do
      [
        {"1.1.1.1", true},
        {"100.0.100.0", true},
        {"0.0.0.0", true},
        {"::", false},
        {"256.2.1.0", false},
        {"255,255,255,255", false},
        {123, false},
        {"a", false},
        {nil, false}
      ]
      |> Enum.each(fn {input, expected_output} ->
        assert expected_output == IP.valid?(input)
      end)
    end
  end
end
