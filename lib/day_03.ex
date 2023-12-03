defmodule Day03 do
  @doc """
  ## Example

      iex> Day03.parse_schematic(["123...456", "...789..."])
      [{123, 0, 0, 2}, {456, 0, 6, 8}, {789, 1, 3, 5}]
  """
  def parse_schematic(schematic) do
    for {schematic_line, line_index} <- Enum.with_index(schematic),
        [{index, length} | _] <- Regex.scan(~r/\d+/, schematic_line, return: :index) do
      {
        schematic_line |> String.slice(index, length) |> Integer.parse() |> elem(0),
        line_index,
        index,
        index + length - 1
      }
    end
  end

  @doc """
  ## Example

      iex> Day03.is_part_number({123, 1, 1, 3}, ["#....", ".123.", "....."])
      true

      iex> Day03.is_part_number({123, 1, 1, 3}, ["..#..", ".123."])
      true

      iex> Day03.is_part_number({123, 1, 1, 3}, [".432.", ".123."])
      false
  """
  def is_part_number({_, number_line, first_char, last_char}, schematic) do
    lines =
      for line_index <- (number_line - 1)..(number_line + 1),
          line_index in 0..upper_bound(schematic) do
        {Enum.at(schematic, line_index), line_index}
      end

    for char <- (first_char - 1)..(last_char + 1),
        {line, line_index} <- lines,
        String.length(line) > 0 and char in 0..upper_bound(line) &&
          (line_index !== number_line || char in [first_char - 1, last_char + 1]) do
      is_symbol(line, char)
    end
    |> Enum.any?()
  end

  defp upper_bound(enumerable) when is_list(enumerable), do: length(enumerable) - 1
  defp upper_bound(enumerable) when is_binary(enumerable), do: String.length(enumerable) - 1

  defp is_symbol(line, char), do: Regex.match?(~r/[^\w\.\s]/, String.at(line, char))
end
