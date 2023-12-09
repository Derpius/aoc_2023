defmodule Day06 do
  @doc ~S"""
  ## Example
  
      iex> Day06.parse_races("Time:      7  15   30\nDistance:  9  40  200")
      [{7, 9}, {15, 40}, {30, 200}]
  """
  def parse_races(races) do
    [time, distance | _] = String.split(races, "\n")
    [parse_row(time), parse_row(distance)] |> Enum.zip()
  end

  @doc ~S"""
  ## Example
  
      iex> Day06.get_num_valid_hold_times({7, 9})
      4
  
      iex> Day06.get_num_valid_hold_times({15, 40})
      8
  
      iex> Day06.get_num_valid_hold_times({30, 200})
      9
  """
  def get_num_valid_hold_times({race_time, winning_distance}) do
    for hold_time <- 1..(race_time - 1), get_distance(hold_time, race_time) > winning_distance do
      1
    end
    |> Enum.sum()
  end

  defp get_distance(hold_time, race_time) do
    hold_time * (race_time - hold_time)
  end

  defp parse_row(row) do
    for [number | _] <- Regex.scan(~r/\d+/, row) do
      {parsed, _} = Integer.parse(number)
      parsed
    end
  end
end
