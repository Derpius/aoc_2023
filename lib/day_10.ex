defmodule Day10 do
  def parse_pipe_diagram(diagram) do
    lines =
      diagram
      |> String.split("\n")
      |> Enum.with_index(fn element, index -> {index, element} end)
      |> Enum.into(%{})

    lines
    |> Enum.find_value(fn {line_number, line} ->
      column = index_of_substring(line, "S")
      if column !== nil, do: {"S", {column, line_number}}
    end)
    |> build_pipe_map(lines, %{})
  end

  def count_inside_area(connections) do
    {max_x, max_y} =
      connections
      |> Map.keys()
      |> Enum.reduce({0, 0}, fn {x, y}, {acc_x, acc_y} -> {max(x, acc_x), max(y, acc_y)} end)

    Enum.reduce(0..max_y, 0, fn y, acc ->
      %{count: count} =
        Enum.reduce(
          0..max_x,
          %{outside: true, count: 0},
          fn x, %{outside: outside, count: count} ->
            case Map.get(connections, {x, y}) do
              pipe when pipe in ["|", "7", "F", "S"] ->
                %{outside: !outside, count: count}

              pipe when pipe in ["-", "J", "L"] ->
                %{outside: outside, count: count}

              _ when outside ->
                %{outside: outside, count: count}

              _ ->
                %{outside: outside, count: count + 1}
            end
          end
        )

      acc + count
    end)
  end

  defp build_pipe_map({pipe, coords}, lines, map) do
    [first, second] = get_pipe_connections({pipe, coords}, lines)
    updated_map = Map.merge(map, %{coords => pipe})
    {_, first_coords} = first
    {_, second_coords} = second

    case {Map.has_key?(map, first_coords), Map.has_key?(map, second_coords)} do
      {true, true} -> updated_map
      {false, true} -> build_pipe_map(first, lines, updated_map)
      {true, false} -> build_pipe_map(second, lines, updated_map)
      {false, false} -> build_pipe_map(first, lines, updated_map)
    end
  end

  @pipes_for_deltas %{
    {-1, 0} => MapSet.new(["-", "L", "F"]),
    {0, -1} => MapSet.new(["|", "F", "7"]),
    {1, 0} => MapSet.new(["-", "J", "7"]),
    {0, 1} => MapSet.new(["|", "L", "J"])
  }

  defp get_pipe_connections({char, {x, y}}, lines) do
    case char do
      "|" -> [{0, -1}, {0, 1}]
      "-" -> [{-1, 0}, {1, 0}]
      "L" -> [{0, -1}, {1, 0}]
      "J" -> [{-1, 0}, {0, -1}]
      "7" -> [{-1, 0}, {0, 1}]
      "F" -> [{1, 0}, {0, 1}]
      "S" -> [{-1, 0}, {0, -1}, {1, 0}, {0, 1}]
      _ -> []
    end
    |> Enum.map(fn {delta_x, delta_y} ->
      coords = {x + delta_x, y + delta_y}
      {get_pipe(coords, lines), coords, {delta_x, delta_y}}
    end)
    |> Enum.filter(fn {char, _, delta} ->
      char !== nil &&
        @pipes_for_deltas[delta] |> MapSet.put("S") |> MapSet.member?(char)
    end)
    |> Enum.map(fn {char, coords, _} -> {char, coords} end)
  end

  defp get_pipe({x, y}, lines) do
    String.at(lines[y], x)
  end

  defp index_of_substring(string, substring) do
    case String.split(string, substring, parts: 2) do
      [left, _] -> String.length(left)
      [_] -> nil
    end
  end
end
