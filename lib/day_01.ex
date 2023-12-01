defmodule Day01 do
  @doc ~S"""
  EEE
  
  ## Examples
  
      iex> Day01.get_calibration_value_for_line("1 two numbers 2")
      12
  
      iex> Day01.get_calibration_value_for_line("one 7 number")
      77
  
      iex> Day01.get_calibration_value_for_line("no numbers")
      0
  
      iex> Day01.get_calibration_value_for_line("321 lots of 456 numbers 789")
      39
  
  """
  def get_calibration_value_for_line(line) do
    {calibration_value, _} =
      line
      |> extract_numbers
      |> concat_first_and_last
      |> Integer.parse()

    calibration_value
  end

  defp extract_numbers(string) do
    Regex.scan(~r/\d/, string) |> Enum.map(fn [number] -> number end)
  end

  defp concat_first_and_last([]), do: "0"
  defp concat_first_and_last([first]), do: first <> first
  defp concat_first_and_last([head | tail]), do: head <> List.last(tail)
end
