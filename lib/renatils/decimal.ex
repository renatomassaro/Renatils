defmodule Renatils.Decimal do
  @doc """
  Converts the input (integer/float/Decimal) to Decimal. Handles `nil` as input.
  """
  def to_decimal(i) when is_integer(i), do: Decimal.new(i)
  def to_decimal(f) when is_float(f), do: Decimal.new("#{f}")
  def to_decimal(%Decimal{} = d), do: d
  def to_decimal(nil), do: nil
end
