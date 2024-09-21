defmodule Renatils.DateTime do
  @typep timestamp :: integer()

  @spec ts_now() :: timestamp()
  def ts_now, do: DateTime.utc_now() |> DateTime.to_unix()
end
