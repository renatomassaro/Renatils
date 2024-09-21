defmodule Renatils.DateTimeTest do
  use ExUnit.Case, async: true

  describe "ts_now/0" do
    test "returns the current timestamp" do
      ts_now =
        DateTime.utc_now()
        |> DateTime.to_unix()

      ts_now_from_renatils = Renatils.DateTime.ts_now()

      assert is_integer(ts_now_from_renatils)
      assert_in_delta ts_now, ts_now_from_renatils, 2
    end
  end
end
