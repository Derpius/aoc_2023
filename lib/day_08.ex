defmodule Day08 do
  @doc """
  Parses a line in the puzzle input
  
      iex> Day08.parse_line("LRLLRLRR")
      "LRLLRLRR"
  
      iex> Day08.parse_line("")
      nil
  
      iex> Day08.parse_line("ABC = (XYZ, ZZZ)")
      {"ABC", {"XYZ", "ZZZ"}}
  """
  def parse_line(""), do: nil

  def parse_line(
        <<key::binary-size(3), " = (", left::binary-size(3), ", ", right::binary-size(3),
          _::binary>>
      ) do
    {key, {left, right}}
  end

  def parse_line(directions), do: directions

  def follow_directions(directions, map),
    do: follow_directions(directions, directions, Enum.into(map, %{}), "AAA", 1)

  defp follow_directions(directions, "", map, current_key, steps),
    do: follow_directions(directions, directions, map, current_key, steps)

  defp follow_directions(
         directions,
         <<direction::binary-size(1), remaining_directions::binary>>,
         map,
         current_key,
         steps
       ) do
    {left_key, right_key} = map[current_key]
    next_key = if direction === "L", do: left_key, else: right_key

    case next_key do
      "ZZZ" -> steps
      _ -> follow_directions(directions, remaining_directions, map, next_key, steps + 1)
    end
  end
end
