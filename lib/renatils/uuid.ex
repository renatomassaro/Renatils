defmodule Renatils.UUID do
  @doc """
  Validates that the UUID is somewhat correct. By no means it's supposed to validate according to
  the specifications. Just make sure it has 36 hexadecimal characters + dashes, with the usual
  format one would expect in an UUID.
  """
  def is_valid?(uuid) when is_binary(uuid) do
    with true <- 36 == String.length(uuid) do
      case String.split(uuid, "-") do
        [a, b, c, d, e] ->
          with true <- 8 == String.length(a),
               true <- 4 == String.length(b),
               true <- 4 == String.length(c),
               true <- 4 == String.length(d),
               true <- 12 == String.length(e),
               true <- Regex.match?(~r/^[a-fA-F0-9-]+$/, uuid) do
            true
          end

        _ ->
          false
      end
    end
  end
end
