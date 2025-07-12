defmodule Renatils.Timer do
  @doc """
  Formats the duration input (precision = microseconds) to a human-friendly format.
  """
  @spec format_duration(microseconds :: integer) ::
          binary()
  def format_duration(d) when d < 1000, do: "#{d}μs"
  def format_duration(d) when d < 10_000, do: "#{Float.round(d / 1000, 2)}ms"
  def format_duration(d) when d < 100_000, do: "#{Float.round(d / 1000, 1)}ms"
  def format_duration(d) when d < 1_000_000, do: "#{trunc(d / 1000)}ms"
  def format_duration(d) when d < 10_000_000, do: "#{Float.round(d / 1_000_000, 1)}s"
  def format_duration(d), do: "#{trunc(d / 1_000_000)}s"
end
