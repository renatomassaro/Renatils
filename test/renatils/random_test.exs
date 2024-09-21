defmodule Renatils.RandomTest do
  use ExUnit.Case, async: true
  alias Renatils.Random

  describe "int/1" do
    test "generates a random int value" do
      generated_value = Random.int()
      assert is_integer(generated_value)
    end
  end
end
