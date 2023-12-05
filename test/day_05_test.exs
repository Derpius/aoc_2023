defmodule Day05Test do
  use ExUnit.Case
  doctest Day05

  @example_almanac """
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
  """

  @parsed_example {
    [79, 14, 55, 13],
    [
      [{-48, 98..99}, {2, 50..97}],
      [{-15, 15..51}, {-15, 52..53}, {39, 0..14}],
      [{-4, 53..60}, {-11, 11..52}, {42, 0..6}, {50, 7..10}],
      [{70, 18..24}, {-7, 25..94}],
      [{-32, 77..99}, {36, 45..63}, {4, 64..76}],
      [{-69, 69..69}, {1, 0..68}],
      [{4, 56..92}, {-37, 93..96}]
    ]
  }

  test "example almanac parsing" do
    parsed =
      @example_almanac
      |> Day05.parse_almanac()

    assert parsed == @parsed_example
  end

  test "example almanac mapping" do
    {_, maps} = @parsed_example

    assert Day05.apply_maps(79, maps) == 82
    assert Day05.apply_maps(14, maps) == 43
    assert Day05.apply_maps(55, maps) == 86
    assert Day05.apply_maps(13, maps) == 35
  end
end
