defmodule Renatils.Random.Int do
  @spec int(opts :: list()) :: integer()
  def int(_opts \\ []) do
    :rand.uniform()
    |> Kernel.*(1_000_000)
    |> trunc()
  end
end
