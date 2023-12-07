defmodule Day05 do
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
        |> Enum.sort(fn {_, a_start.._}, {_, b_start.._} -> a_start <= b_start end)
      end

    {parsed_seeds, parsed_maps}
  end

  def apply_maps(seed, maps) when is_number(seed) and is_list(maps) do
    Enum.reduce(maps, seed, &apply_map/2)
  end

  def apply_maps(seed_ranges, maps) when is_list(seed_ranges) and is_list(maps) do
    Enum.reduce(maps, seed_ranges, fn map, ranges ->
      for range <- ranges, mapped_range <- apply_map(map, range) do
        mapped_range
      end
    end)
  end

  defp apply_map(map, value) when is_list(map) and is_number(value) do
    {offset, _} = Enum.find(map, {0, nil}, fn {_, source_range} -> value in source_range end)
    value + offset
  end

  defp apply_map([], range), do: [range]

  defp apply_map([{offset, map_range} | map_tail], range) do
    case split_range_by_range(range, map_range) do
      {left, nil, nil} when not is_nil(left) ->
        [left]

      {nil, nil, right} when not is_nil(right) ->
        apply_map(map_tail, right)

      {left, middle, nil} when not is_nil(left) and not is_nil(middle) ->
        [left, offset_range(middle, offset)]

      {nil, middle, nil} when not is_nil(middle) ->
        [offset_range(middle, offset)]

      {nil, middle, right} when not is_nil(middle) and not is_nil(right) ->
        [offset_range(middle, offset) | apply_map(map_tail, right)]

      {left, middle, right} when not is_nil(left) and not is_nil(middle) and not is_nil(right) ->
        [left, offset_range(middle, offset) | apply_map(map_tail, right)]
    end
  end

  defp parse_integer!(str) when is_binary(str) do
    {parsed, _} = Integer.parse(str)
    parsed
  end

  defp split_range_by_range(range_start..range_end, split_range_start..split_range_end) do
    cond do
      range_end < split_range_start ->
        {range_start..range_end, nil, nil}

      range_start > split_range_end ->
        {nil, nil, range_start..range_end}

      range_start < split_range_start && range_end <= split_range_end ->
        {range_start..(split_range_start - 1), split_range_start..range_end, nil}

      range_start >= split_range_start && range_end <= split_range_end ->
        {nil, range_start..range_end, nil}

      range_start >= split_range_start && range_end > split_range_end ->
        {nil, range_start..split_range_end, (split_range_end + 1)..range_end}

      true ->
        {
          range_start..(split_range_start - 1),
          split_range_start..split_range_end,
          (split_range_end + 1)..range_end
        }
    end
  end

  defp offset_range(range_start..range_end, offset) do
    (range_start + offset)..(range_end + offset)
  end
end
