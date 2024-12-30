defmodule Renatils.DecimalTest do
  use ExUnit.Case, async: true

  describe "to_decimal/1" do
    test "returns expected results" do
      [
        {0, Decimal.new(0)},
        {123, Decimal.new(123)},
        {123.0, Decimal.new("123.0")},
        {-1.7, Decimal.new("-1.7")},
        {Decimal.new("500"), Decimal.new(500)},
        {nil, nil}
      ]
      |> Enum.each(fn
        {nil, nil} ->
          assert Renatils.Decimal.to_decimal(nil) == nil

        {input, expected_output} ->
          assert Decimal.eq?(expected_output, Renatils.Decimal.to_decimal(input))
      end)
    end
  end
end
