defmodule Renatils.Random.UUIDTest do
  use ExUnit.Case, async: true
  alias Renatils.Random

  describe "uuid/1" do
    test "generates random, valid UUIDs" do
      Enum.each(1..100, fn _ ->
        uuid = Random.UUID.uuid()
        assert Renatils.UUID.is_valid?(uuid)
      end)
    end
  end
end
