defmodule Day03 do
  @doc """
  ## Example

      iex> Day03.parse_schematic_numbers(["123...456", "...789..."])
      [{123, 0, 0, 2}, {456, 0, 6, 8}, {789, 1, 3, 5}]
  """
  def parse_schematic_numbers(schematic) do
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
  def is_part_number(number, schematic) do
    number |> get_symbols_for_number(schematic) |> Enum.empty?() |> Kernel.not()
  end

  @doc """
  ## Example

      iex> Day03.get_gear_ratios([{10, 0, 0, 1}, {20, 0, 3, 4}, {30, 2, 0, 1}, {40, 2, 3, 4}], ["10*20", ".....", "30#40"])
      [200]
  """
  def get_gear_ratios(numbers, schematic) do
    for number <- numbers,
        {gear_char, gear_line} <- get_symbols_for_number(number, schematic, ~r/\*/) do
      {gear_char * length(schematic) + gear_line, number}
    end
    |> Enum.group_by(fn {gear_id, _} -> gear_id end, fn {_, {number, _, _, _}} -> number end)
    |> Map.values()
    |> Enum.filter(&length(&1) === 2)
    |> Enum.map(fn [a, b] -> a * b end)
  end

  defp get_symbols_for_number(
         {_, number_line, first_char, last_char},
         schematic,
         filter \\ ~r/[^\w\s\.]/
       ) do
    lines =
      for line_index <- (number_line - 1)..(number_line + 1),
          line_index in 0..upper_bound(schematic) do
        {Enum.at(schematic, line_index), line_index}
      end

    for char <- (first_char - 1)..(last_char + 1),
        {line, line_index} <- lines,
        String.length(line) > 0 &&
          char in 0..upper_bound(line) &&
          (line_index !== number_line || char in [first_char - 1, last_char + 1]) &&
          Regex.match?(filter, String.at(line, char)) do
      {char, line_index}
    end
  end

  defp upper_bound(enumerable) when is_list(enumerable), do: length(enumerable) - 1
  defp upper_bound(enumerable) when is_binary(enumerable), do: String.length(enumerable) - 1
end
