defmodule Day04 do
  @doc """
  ## Example

      iex> Day04.parse_scratchcard("Card 1: 12  3 45 |  6 78  9")
      {MapSet.new([12, 3, 45]), MapSet.new([6, 78, 9])}
  """
  def parse_scratchcard(scratchcard) do
    [_, winning_numbers, chosen_numbers] =
      Regex.run(~r/^Card\s+\d+: ([\s\d]+) \| ([\s\d]+)$/, scratchcard)

    {parse_numbers(winning_numbers), parse_numbers(chosen_numbers)}
  end

  @doc """
  ## Example

      iex> Day04.get_scratchcard_value({MapSet.new([41, 48, 83, 86, 17]), MapSet.new([83, 86, 6, 31, 17, 9, 48, 53])})
      8
  """
  def get_scratchcard_value(scratchcard) do
    case get_matching_numbers(scratchcard) do
      0 -> 0
      x -> 2 ** (x - 1)
    end
  end

  def get_copies(scratchcard_table) when is_list(scratchcard_table) do
    scratchcard_table
    |> List.foldr([], fn scratchcard, acc ->
      matches = get_matching_numbers(scratchcard)
      copies = acc |> Enum.slice(0, matches) |> Enum.sum()
      [copies + 1 | acc]
    end)
    |> Enum.sum()
  end

  defp get_matching_numbers({winning_numbers, chosen_numbers}),
    do: chosen_numbers |> MapSet.intersection(winning_numbers) |> MapSet.size()

  defp parse_numbers(numbers) do
    for <<number::binary-3 <- numbers <> " ">> do
      {parsed, _} = number |> String.trim() |> Integer.parse()
      parsed
    end
    |> MapSet.new()
  end
end
