defmodule Renatils.IP do
  def valid?(string) when is_binary(string) do
    string
    |> String.to_charlist()
    |> :inet.parse_ipv4strict_address()
    |> then(fn
      {:ok, _} -> true
      _ -> false
    end)
  end

  def valid?(_), do: false
end
