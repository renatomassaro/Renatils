defmodule Renatils.UUIDTest do
  use ExUnit.Case, async: true

  describe "is_valid?/1" do
    test "validates the uuid" do
      invalid_uuids =
        [
          "",
          # Contains non-hex character
          "zeebfeeb-feeb-feeb-feeb-feebfeebfeeb",
          # Incorrect number of dashes
          "feebfeebfeebfeebfeebfeebfeebfeeb",
          "feebfeeb0feeb0feeb-feeb-feebfeebfeeb",
          # With dashes but with invalid length between them
          "feebfee-bfeeb-feeb-feeb-feebfeebfeeb",
          "feebfeeb-fee-bfeeb-feeb-feebfeebfeeb",
          "feebfeeb-feeb-fee-bfeeb-feebfeebfeeb",
          "feebfeeb-feeb-feeb-fee-bfeebfeebfeeb"
        ]

      valid_uuids =
        [
          "feebfeeb-feeb-feeb-feeb-feebfeebfeeb",
          "FEEBFEEB-FEEB-FEEB-FEEB-FEEBFEEBFEEB",
          "fEeBfEeB-FeEb-fEeB-FeEb-FeEbFeEbFeEb"
        ]

      Enum.each(valid_uuids, fn uuid -> assert Renatils.UUID.is_valid?(uuid) end)
      Enum.each(invalid_uuids, fn uuid -> refute Renatils.UUID.is_valid?(uuid) end)
    end

    test "crashes if non-binary input is passed" do
      # This is on purpose. The function contract is String -> Boolean
      assert_raise FunctionClauseError, fn ->
        Renatils.UUID.is_valid?([])
      end
    end
  end
end
