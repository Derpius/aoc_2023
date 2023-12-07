defmodule AdventOfCode do
  def day1_part1() do
    File.stream!("./problems/01.txt")
    |> Stream.map(fn line -> Day01.get_calibration_value_for_line(line, with_words: false) end)
    |> Enum.sum()
  end

  def day1_part2() do
    File.stream!("./problems/01.txt")
    |> Stream.map(fn line -> Day01.get_calibration_value_for_line(line, with_words: true) end)
    |> Enum.sum()
  end

  def day2_part1() do
    File.stream!("./problems/02.txt")
    |> Stream.filter(&Day02.is_valid_game_record/1)
    |> Stream.map(&Day02.parse_game_id/1)
    |> Enum.sum()
  end

  def day2_part2() do
    File.stream!("./problems/02.txt")
    |> Stream.map(&Day02.get_game_record_power/1)
    |> Enum.sum()
  end

  def day3_part1() do
    schematic = File.stream!("./problems/03.txt") |> Enum.to_list()

    schematic
    |> Day03.parse_schematic_numbers()
    |> Enum.filter(&Day03.is_part_number(&1, schematic))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def day3_part2() do
    schematic = File.stream!("./problems/03.txt") |> Enum.to_list()

    schematic
    |> Day03.parse_schematic_numbers()
    |> Day03.get_gear_ratios(schematic)
    |> Enum.sum()
  end

  def day4_part1() do
    File.stream!("./problems/04.txt")
    |> Stream.map(fn card ->
      card |> Day04.parse_scratchcard() |> Day04.get_scratchcard_value()
    end)
    |> Enum.sum()
  end

  def day4_part2() do
    File.stream!("./problems/04.txt")
    |> Stream.map(&Day04.parse_scratchcard/1)
    |> Enum.to_list()
    |> Day04.get_copies()
  end

  def day5_part1() do
    {seeds, maps} = "./problems/05.txt" |> File.read!() |> Day05.parse_almanac()

    seeds |> Enum.map(&Day05.apply_maps(&1, maps)) |> Enum.min()
  end

  def day5_part2() do
    {seeds, maps} = "./problems/05.txt" |> File.read!() |> Day05.parse_almanac()

    seed_ranges =
      seeds
      |> Enum.chunk_every(2)
      |> Enum.map(fn [range_start, range_length] ->
        range_start..(range_start + range_length - 1)
      end)

    lowest_location.._ =
      seed_ranges
      |> Day05.apply_maps(maps)
      |> Enum.sort(fn a_start.._, b_start.._ -> a_start <= b_start end)
      |> hd

    lowest_location
  end
end
