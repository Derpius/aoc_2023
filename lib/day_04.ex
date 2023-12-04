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
  def get_scratchcard_value({winning_numbers, chosen_numbers}) do
    num_matching_numbers = chosen_numbers |> MapSet.intersection(winning_numbers) |> MapSet.size()

    case num_matching_numbers do
      0 -> 0
      x -> 2 ** (x - 1)
    end
  end

  defp parse_numbers(numbers) do
    for <<number::binary-3 <- numbers <> " ">> do
      {parsed, _} = number |> String.trim() |> Integer.parse()
      parsed
    end
    |> MapSet.new()
  end
end
