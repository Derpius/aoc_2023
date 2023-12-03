defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  @example_schematic """
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

  test "example schematic" do
    valid_numbers =
      @example_schematic
      |> Day03.parse_schematic_numbers()
      |> Enum.filter(&Day03.is_part_number(&1, @example_schematic))
      |> Enum.map(&elem(&1, 0))

    assert valid_numbers == [467, 35, 633, 617, 592, 755, 664, 598]
  end
end
