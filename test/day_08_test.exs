defmodule Day08Test do
  use ExUnit.Case
  doctest Day08

  test "solves simple example" do
    network =
      """
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
      """
      |> String.trim()
      |> String.split("\n")

    [directions, _ | map] = network |> Enum.map(&Day08.parse_line/1)

    steps = Day08.follow_directions(directions, map)

    assert steps === 2
  end

  test "solves repeating example" do
    network =
      """
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
      """
      |> String.trim()
      |> String.split("\n")

    [directions, _ | map] = network |> Enum.map(&Day08.parse_line/1)

    steps = Day08.follow_directions(directions, map)

    assert steps === 6
  end
end
