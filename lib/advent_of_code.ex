defmodule AdventOfCode do
  @doc ~S"""
  Day 1: Trebuchet

  ## Examples

      iex> AdventOfCode.day1("1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet")
      142

  """
  def day1(calibration_document) do
    calibration_document
    |> String.split("\n")
    |> Enum.map(&Day01.get_calibration_value_for_line/1)
    |> Enum.sum()
  end
end
