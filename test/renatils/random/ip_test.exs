defmodule Renatils.Random.IPTest do
  use ExUnit.Case, async: true
  alias Renatils.Random

  describe "ip/1" do
    test "generates a random IP (IPv4 by default)" do
      Enum.each(1..1000, fn _ ->
        ip = Random.ip()

        assert [raw_oct_1, raw_oct_2, raw_oct_3, raw_oct_4] = String.split(ip, ".")

        [oct_1, oct_2, oct_3, oct_4] = [
          String.to_integer(raw_oct_1),
          String.to_integer(raw_oct_2),
          String.to_integer(raw_oct_3),
          String.to_integer(raw_oct_4)
        ]

        assert oct_1 >= 0 and oct_1 <= 255
        assert oct_2 >= 0 and oct_2 <= 255
        assert oct_3 >= 0 and oct_3 <= 255
        assert oct_4 >= 0 and oct_4 <= 255

        assert Renatils.IP.valid?(ip)
      end)
    end
  end
end
