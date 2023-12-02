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
end
