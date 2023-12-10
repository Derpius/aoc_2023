defmodule Day10Test do
  use ExUnit.Case

  @parsed_simple_example %{
    {1, 1} => "S",
    {2, 1} => "-",
    {3, 1} => "7",
    {1, 2} => "|",
    {3, 2} => "|",
    {1, 3} => "L",
    {2, 3} => "-",
    {3, 3} => "J"
  }

  @parsed_complex_example %{
    {2, 0} => "F",
    {3, 0} => "7",
    {1, 1} => "F",
    {2, 1} => "J",
    {3, 1} => "|",
    {0, 2} => "S",
    {1, 2} => "J",
    {3, 2} => "L",
    {4, 2} => "7",
    {0, 3} => "|",
    {1, 3} => "F",
    {2, 3} => "-",
    {3, 3} => "-",
    {4, 3} => "J",
    {0, 4} => "L",
    {1, 4} => "J"
  }

  test "parses simple example" do
    diagram = """
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    """

    parsed = Day10.parse_pipe_diagram(diagram)

    assert parsed == @parsed_simple_example
  end

  test "parses simple example with decoys" do
    diagram = """
    -L|F7
    7S-7|
    L|7||
    -L-J|
    L|-JF
    """

    parsed = Day10.parse_pipe_diagram(diagram)

    assert parsed == @parsed_simple_example
  end

  test "parses complex example" do
    diagram = """
    ..F7.
    .FJ|.
    SJ.L7
    |F--J
    LJ...
    """

    parsed = Day10.parse_pipe_diagram(diagram)

    assert parsed == @parsed_complex_example
  end

  test "parses complex example with decoys" do
    diagram = """
    7-F7-
    .FJ|7
    SJLL7
    |F--J
    LJ.LJ
    """

    parsed = Day10.parse_pipe_diagram(diagram)

    assert parsed == @parsed_complex_example
  end

  test "parses and solves part 2 example" do
    diagram = """
    .F----7F7F7F7F-7....
    .|F--7||||||||FJ....
    .||.FJ||||||||L7....
    FJL7L7LJLJ||LJ.L-7..
    L--J.L7...LJS7F-7L7.
    ....F-J..F7FJ|L7L7L7
    ....L7.F7||L7|.L7L7|
    .....|FJLJ|FJ|F7|.LJ
    ....FJL-7.||.||||...
    ....L---J.LJ.LJLJ...
    """

    inside_area = diagram |> Day10.parse_pipe_diagram() |> Day10.count_inside_area()

    assert inside_area === 8
  end
end
