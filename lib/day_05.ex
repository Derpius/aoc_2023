defmodule Day05 do
  # Split at double newlines

  # Parse maps into data structure

  # Transform source value to destination value via maps
  # seed > soil > fertiliser > water > light > temperature > humidity > location

  # transform number to single map
  # list of ranges
  # each range:
  #  offset = d - s (add offset to source)
  #  elixir range

  def parse_almanac(almanac) when is_binary(almanac) do
    ["seeds: " <> seeds | maps] = String.split(almanac, "\n\n")

    parsed_seeds = seeds |> String.split(" ") |> Enum.map(&parse_integer!/1)

    parsed_maps =
      for map <- maps do
        for range <- map |> String.split("\n") |> tl, range !== "" do
          [destination_start, source_start, range_length] =
            Regex.run(~r/(\d+) (\d+) (\d+)/, range) |> tl |> Enum.map(&parse_integer!/1)

          {
            destination_start - source_start,
            source_start..(source_start + range_length - 1)
          }
        end
      end

    {parsed_seeds, parsed_maps}
  end

  def apply_maps(seed, maps) when is_number(seed) and is_list(maps) do
    Enum.reduce(maps, seed, &apply_map/2)
  end

  defp apply_map(map, value) when is_list(map) and is_number(value) do
    {offset, _} = Enum.find(map, {0, nil}, fn {_, source_range} -> value in source_range end)
    value + offset
  end

  defp parse_integer!(str) when is_binary(str) do
    {parsed, _} = Integer.parse(str)
    parsed
  end
end
