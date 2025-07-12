defmodule Renatils.TimerTest do
  use ExUnit.Case, async: true

  describe "format_duration/1" do
    test "formats the input based on its order of magnitude" do
      [
        {5, "5μs"},
        {51, "51μs"},
        {510, "510μs"},
        {5_100, "5.1ms"},
        {51_100, "51.1ms"},
        {511_100, "511ms"},
        {5_111_100, "5.1s"},
        {51_111_100, "51s"},
        {510_111_100, "510s"}
      ]
      |> Enum.each(fn {input, expected_format} ->
        assert expected_format == Renatils.Timer.format_duration(input)
      end)
    end
  end
end
