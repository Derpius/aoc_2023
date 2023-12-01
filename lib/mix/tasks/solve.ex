defmodule Mix.Tasks.Solve do
  use Mix.Task

  def run(["1"]) do
    AdventOfCode.day1_part1() |> IO.inspect(label: "Part 1")
    AdventOfCode.day1_part2() |> IO.inspect(label: "Part 2")
  end
end
