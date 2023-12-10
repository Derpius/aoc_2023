defmodule Day10Test do
  use ExUnit.Case

  @parsed_simple_example {
    {"S", {1, 1}},
    %{
      {"S", {1, 1}} => {{"-", {2, 1}}, {"|", {1, 2}}},
      {"-", {2, 1}} => {{"S", {1, 1}}, {"7", {3, 1}}},
      {"7", {3, 1}} => {{"-", {2, 1}}, {"|", {3, 2}}},
      {"|", {1, 2}} => {{"S", {1, 1}}, {"L", {1, 3}}},
      {"|", {3, 2}} => {{"7", {3, 1}}, {"J", {3, 3}}},
      {"L", {1, 3}} => {{"|", {1, 2}}, {"-", {2, 3}}},
      {"-", {2, 3}} => {{"L", {1, 3}}, {"J", {3, 3}}},
      {"J", {3, 3}} => {{"-", {2, 3}}, {"|", {3, 2}}}
    }
  }

  @parsed_complex_example {
    {"S", {0, 2}},
    %{
      {"F", {2, 0}} => {{"7", {3, 0}}, {"J", {2, 1}}},
      {"7", {3, 0}} => {{"F", {2, 0}}, {"|", {3, 1}}},
      {"F", {1, 1}} => {{"J", {2, 1}}, {"J", {1, 2}}},
      {"J", {2, 1}} => {{"F", {1, 1}}, {"F", {2, 0}}},
      {"|", {3, 1}} => {{"7", {3, 0}}, {"L", {3, 2}}},
      {"S", {0, 2}} => {{"J", {1, 2}}, {"|", {0, 3}}},
      {"J", {1, 2}} => {{"S", {0, 2}}, {"F", {1, 1}}},
      {"L", {3, 2}} => {{"|", {3, 1}}, {"7", {4, 2}}},
      {"7", {4, 2}} => {{"L", {3, 2}}, {"J", {4, 3}}},
      {"|", {0, 3}} => {{"S", {0, 2}}, {"L", {0, 4}}},
      {"F", {1, 3}} => {{"-", {2, 3}}, {"J", {1, 4}}},
      {"-", {2, 3}} => {{"F", {1, 3}}, {"-", {3, 3}}},
      {"-", {3, 3}} => {{"-", {2, 3}}, {"J", {4, 3}}},
      {"J", {4, 3}} => {{"-", {3, 3}}, {"7", {4, 2}}},
      {"L", {0, 4}} => {{"|", {0, 3}}, {"J", {1, 4}}},
      {"J", {1, 4}} => {{"L", {0, 4}}, {"F", {1, 3}}}
    }
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
end
