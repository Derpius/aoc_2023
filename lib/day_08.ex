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

  def follow_directions(
        directions,
        map,
        starting_key \\ "AAA",
        stop_function \\ fn x -> x === "ZZZ" end
      ),
      do:
        follow_directions(
          directions,
          directions,
          Enum.into(map, %{}),
          stop_function,
          starting_key,
          1
        )

  @doc """
  Returns the lowest common multiple of two integers

  ## Example

      iex> Day08.lcm(7, 13)
      91
  """
  def lcm(a, b) when is_integer(a) and is_integer(b) do
    trunc(a * b / Integer.gcd(a, b))
  end

  defp follow_directions(directions, "", map, stop_function, current_key, steps),
    do: follow_directions(directions, directions, map, stop_function, current_key, steps)

  defp follow_directions(
         directions,
         <<direction::binary-size(1), remaining_directions::binary>>,
         map,
         stop_function,
         current_key,
         steps
       ) do
    {left_key, right_key} = map[current_key]
    next_key = if direction === "L", do: left_key, else: right_key

    if stop_function.(next_key),
      do: steps,
      else:
        follow_directions(
          directions,
          remaining_directions,
          map,
          stop_function,
          next_key,
          steps + 1
        )
  end
end
