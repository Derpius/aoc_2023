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

  test "example schematic part numbers" do
    part_numbers =
      @example_schematic
      |> Day03.parse_schematic_numbers()
      |> Enum.filter(&Day03.is_part_number(&1, @example_schematic))
      |> Enum.map(&elem(&1, 0))

    assert part_numbers == [467, 35, 633, 617, 592, 755, 664, 598]
  end

  test "example schematic gear ratios" do
    gear_ratios =
      @example_schematic
      |> Day03.parse_schematic_numbers()
      |> Day03.get_gear_ratios(@example_schematic)

    assert gear_ratios == [16345, 451_490]
  end
end
