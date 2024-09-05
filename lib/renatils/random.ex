defmodule Renatils.Random do
  @moduledoc """
  Exposes a curated API that can be accessed directly from `Renatils.Random`.
  """

  alias __MODULE__

  defdelegate int(opts \\ []), to: Random.Int
  defdelegate uuid(opts \\ []), to: Random.UUID
end
