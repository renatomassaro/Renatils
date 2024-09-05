defmodule Renatils.JSON do
  # DOCME
  def encode!(data) do
    data
    |> :json.encode(&encoder/2)
    |> IO.iodata_to_binary()
  end

  # DOCME
  # TODO: Add support for `keys: :atom|string`
  def decode!(data) do
    {result, :ok, ""} = :json.decode(data, :ok, %{null: nil})
    result
  end

  defp encoder(nil, _encoder), do: "null"
  defp encoder(v, encoder), do: :json.encode_value(v, encoder)
end
