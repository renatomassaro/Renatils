defmodule Renatils.Random.IP do
  @doc """
  Generates a GoodEnough(TM) IPv4 address. Does not take into consideration private ranges and such.
  """
  @spec ip(opts :: list()) :: String.t()
  def ip(_opts \\ []) do
    Enum.map_join(1..4, ".", fn _ ->
      (256 * :rand.uniform())
      |> Float.floor()
      |> trunc()
    end)
  end
end
