defmodule Renatils.Map do
  def atomify_keys(map, opts \\ [])

  def atomify_keys(map, opts) when is_map(map) do
    atomify_fun =
      if Keyword.get(opts, :with_existing_atom, false),
        do: &String.to_existing_atom/1,
        else: &String.to_atom/1

    Enum.reduce(map, %{}, fn {k, v}, acc ->
      cond do
        is_atom(k) ->
          Map.put(acc, k, atomify_keys(v, opts))

        is_binary(k) ->
          Map.put(acc, atomify_fun.(k), atomify_keys(v, opts))

        true ->
          Map.put(acc, k, atomify_keys(v, opts))
      end
    end)
  end

  def atomify_keys(v, _), do: v

  # DOCME
  def safe_atomify_keys(map),
    do: atomify_keys(map, with_existing_atom: true)

  # DOCME
  def stringify_keys(map) when is_map(map) do
    Enum.reduce(map, %{}, fn {k, v}, acc ->
      cond do
        # `nil` and `true` are atoms, but we don't want to stringify them
        (is_atom(k) or is_number(k)) and not (is_boolean(k) or is_nil(k)) ->
          Map.put(acc, "#{k}", stringify_keys(v))

        is_binary(k) ->
          Map.put(acc, k, stringify_keys(v))

        true ->
          Map.put(acc, k, stringify_keys(v))
      end
    end)
  end

  def stringify_keys(v), do: v
end
