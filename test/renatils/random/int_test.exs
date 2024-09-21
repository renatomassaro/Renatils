defmodule Renatils.Random.IntTest do
  use ExUnit.Case, async: true
  alias Renatils.Random

  describe "int/1" do
    test "generates a random int value" do
      generated_value = Random.Int.int()
      assert is_integer(generated_value)
    end
  end
end
