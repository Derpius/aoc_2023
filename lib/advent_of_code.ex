defmodule AdventOfCode do
  def day1() do
    File.stream!("./problems/01.txt")
    |> Stream.map(&Day01.get_calibration_value_for_line/1)
    |> Enum.sum()
  end
end
