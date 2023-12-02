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
end
