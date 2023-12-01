defmodule Day01 do
  @doc ~S"""
  ## Examples
  
      iex> Day01.get_calibration_value_for_line("1 two numbers 2", with_words: false)
      12
  
      iex> Day01.get_calibration_value_for_line("one 7 number", with_words: false)
      77
  
      iex> Day01.get_calibration_value_for_line("no numbers", with_words: false)
      0
  
      iex> Day01.get_calibration_value_for_line("321 lots of 456 numbers 789", with_words: false)
      39
  
      iex> Day01.get_calibration_value_for_line("two1nine", with_words: true)
      29
  
      iex> Day01.get_calibration_value_for_line("eightwothree",with_words:  true)
      83
  
      iex> Day01.get_calibration_value_for_line("abcone2threexyz", with_words: true)
      13
  
      iex> Day01.get_calibration_value_for_line("34dcnd8eightwombx", with_words: true)
      32
  
  """
  def get_calibration_value_for_line(line, with_words: false) do
    {calibration_value, _} =
      line
      |> extract_numbers
      |> concat_first_and_last
      |> Integer.parse()

    calibration_value
  end

  def get_calibration_value_for_line(line, with_words: true) do
    {calibration_value, _} =
      line
      |> extract_numbers_and_words
      |> concat_first_and_last
      |> Integer.parse()

    calibration_value
  end

  defp extract_numbers_and_words(string) do
    Regex.scan(~r/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/, string)
    |> Enum.map(fn [_, number] ->
      case number do
        "one" -> "1"
        "two" -> "2"
        "three" -> "3"
        "four" -> "4"
        "five" -> "5"
        "six" -> "6"
        "seven" -> "7"
        "eight" -> "8"
        "nine" -> "9"
        any -> any
      end
    end)
  end

  defp extract_numbers(string) do
    Regex.scan(~r/\d/, string) |> Enum.map(fn [number] -> number end)
  end

  defp concat_first_and_last([]), do: "0"
  defp concat_first_and_last([first]), do: first <> first
  defp concat_first_and_last([head | tail]), do: head <> List.last(tail)
end
