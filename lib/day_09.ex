defmodule Day09 do
  @doc """
  ## Example
  
      iex> Day09.parse_sequence("1 -2 34 -567 89 0")
      [1, -2, 34, -567, 89, 0]
  """
  def parse_sequence(sequence) do
    for [number] <- Regex.scan(~r/-?\d+/, sequence) do
      {parsed, _} = Integer.parse(number)
      parsed
    end
  end

  @doc """
  ## Example
  
      iex> Day09.get_next_value([10, 13, 16, 21, 30, 45])
      68
  """
  def get_next_value(sequence) do
    differences = get_differences(sequence)

    if Enum.all?(differences, &(&1 === 0)) do
      List.last(sequence)
    else
      List.last(sequence) + get_next_value(differences)
    end
  end

  defp get_differences([first, second | rest]) do
    [second - first | get_differences([second | rest])]
  end

  defp get_differences([_]), do: []
end
