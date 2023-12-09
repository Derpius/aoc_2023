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

  def day6_part1() do
    "./problems/06.txt"
    |> File.read!()
    |> Day06.parse_races()
    |> Enum.reduce(1, fn race, acc ->
      acc * Day06.get_num_valid_hold_times(race)
    end)
  end

  def day6_part2() do
    {string_time, string_distance} =
      "./problems/06.txt"
      |> File.read!()
      |> Day06.parse_races()
      |> Enum.reduce({"", ""}, fn {time, distance}, {acc_time, acc_distance} ->
        {
          acc_time <> Integer.to_string(time),
          acc_distance <> Integer.to_string(distance)
        }
      end)

    {time, _} = Integer.parse(string_time)
    {distance, _} = Integer.parse(string_distance)

    Day06.get_num_valid_hold_times({time, distance})
  end

  def day7_part1() do
    "./problems/07.txt"
    |> File.stream!()
    |> Stream.map(&Day07.parse_hand/1)
    |> Enum.sort(fn a, b -> !Day07.hand_a_beats_b(a, b) end)
    |> Enum.with_index(1)
    |> Enum.map(fn {%{bid: bid}, rank} -> bid * rank end)
    |> Enum.sum()
  end

  def day7_part2() do
    "./problems/07.txt"
    |> File.stream!()
    |> Stream.map(&Day07.parse_hand(&1, true))
    |> Enum.sort(fn a, b -> !Day07.hand_a_beats_b(a, b, true) end)
    |> Enum.with_index(1)
    |> Enum.map(fn {%{bid: bid}, rank} -> bid * rank end)
    |> Enum.sum()
  end

  def day8_part1() do
    [directions, _ | map] =
      "./problems/08.txt"
      |> File.stream!()
      |> Stream.map(&Day08.parse_line/1)
      |> Enum.to_list()

    directions |> String.trim() |> Day08.follow_directions(map)
  end

  def day8_part2() do
    [directions, _ | map] =
      "./problems/08.txt"
      |> File.stream!()
      |> Stream.map(&Day08.parse_line/1)
      |> Enum.to_list()

    starting_keys =
      map |> Enum.filter(fn {key, _} -> String.ends_with?(key, "A") end) |> Enum.map(&elem(&1, 0))

    for starting_key <- starting_keys do
      Task.async(fn ->
        directions
        |> String.trim()
        |> Day08.follow_directions(map, starting_key, &String.ends_with?(&1, "Z"))
      end)
    end
    |> Task.await_many()
    |> Enum.reduce(&Day08.lcm/2)
  end

  def day9_part1() do
    "./problems/09.txt"
    |> File.stream!()
    |> Stream.map(&Day09.parse_sequence/1)
    |> Stream.map(&Day09.get_next_value/1)
    |> Enum.sum()
  end

  def day9_part2() do
    "./problems/09.txt"
    |> File.stream!()
    |> Stream.map(&Day09.parse_sequence/1)
    |> Stream.map(&Day09.get_previous_value/1)
    |> Enum.sum()
  end
end
