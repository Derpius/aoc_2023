defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "example schematic" do
    schematic =
      """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """
      |> String.split("\n")

    valid_numbers =
      schematic
      |> Day03.parse_schematic()
      |> Enum.filter(&Day03.is_part_number(&1, schematic))
      |> Enum.map(&elem(&1, 0))

    assert valid_numbers == [467, 35, 633, 617, 592, 755, 664, 598]
  end
end
