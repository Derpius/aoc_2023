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
end
