defmodule Mix.Tasks.Solve do
  use Mix.Task

  def run(["1"]) do
    AdventOfCode.day1() |> IO.puts()
  end
end
