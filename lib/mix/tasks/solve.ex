defmodule Mix.Tasks.Solve do
  use Mix.Task

  def run(["1"]) do
    AdventOfCode.day1_part1() |> IO.inspect(label: "Part 1")
    AdventOfCode.day1_part2() |> IO.inspect(label: "Part 2")
  end

  def run(["2"]) do
    AdventOfCode.day2_part1() |> IO.inspect(label: "Part 1")
    AdventOfCode.day2_part2() |> IO.inspect(label: "Part 2")
  end

  def run(["3"]) do
    AdventOfCode.day3_part1() |> IO.inspect(label: "Part 1")
    AdventOfCode.day3_part2() |> IO.inspect(label: "Part 2")
  end

  def run(["4"]) do
    AdventOfCode.day4_part1() |> IO.inspect(label: "Part 1")
    AdventOfCode.day4_part2() |> IO.inspect(label: "Part 2")
  end

  def run(["5"]) do
    AdventOfCode.day5_part1() |> IO.inspect(label: "Part 1")
  end
end
