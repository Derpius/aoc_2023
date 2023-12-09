defmodule Day07Test do
  use ExUnit.Case

  @example_hands [
    "32T3K 765",
    "T55J5 684",
    "KK677 28",
    "KTJJT 220",
    "QQQJA 483"
  ]

  for hand <- [
        %{hand: "AAAAA", value: 7, bid: 54321},
        %{hand: "AA8AA", value: 6, bid: 1},
        %{hand: "23332", value: 5, bid: 1},
        %{hand: "TTT98", value: 4, bid: 1},
        %{hand: "23432", value: 3, bid: 1},
        %{hand: "A23A4", value: 2, bid: 1},
        %{hand: "23456", value: 1, bid: 1}
      ] do
    test "parses hand #{hand.hand}" do
      parsed = Day07.parse_hand("#{unquote(hand.hand)} #{unquote(hand.bid)}")

      assert parsed == unquote(Macro.escape(hand))
    end
  end

  for hand <- [
        %{hand: "JJJJ1", value: 7, bid: 1},
        %{hand: "JJJJJ", value: 7, bid: 1},
        %{hand: "JJJ12", value: 6, bid: 1},
        %{hand: "JJ112", value: 6, bid: 1},
        %{hand: "JJ123", value: 4, bid: 1},
        %{hand: "J1234", value: 2, bid: 1}
      ] do
    test "parses hand #{hand.hand} with jokers" do
      parsed = Day07.parse_hand("#{unquote(hand.hand)} #{unquote(hand.bid)}", true)

      assert parsed == unquote(Macro.escape(hand))
    end
  end

  test "parses and ranks example hands" do
    ranked_hands =
      @example_hands
      |> Enum.map(&Day07.parse_hand/1)
      |> Enum.sort(fn a, b -> !Day07.hand_a_beats_b(a, b) end)

    assert ranked_hands == [
             %{hand: "32T3K", value: 2, bid: 765},
             %{hand: "KTJJT", value: 3, bid: 220},
             %{hand: "KK677", value: 3, bid: 28},
             %{hand: "T55J5", value: 4, bid: 684},
             %{hand: "QQQJA", value: 4, bid: 483}
           ]
  end

  test "parses and ranks example hands with jokers" do
    ranked_hands =
      @example_hands
      |> Enum.map(&Day07.parse_hand(&1, true))
      |> Enum.sort(fn a, b -> !Day07.hand_a_beats_b(a, b, true) end)

    assert ranked_hands == [
             %{hand: "32T3K", value: 2, bid: 765},
             %{hand: "KK677", value: 3, bid: 28},
             %{hand: "T55J5", value: 6, bid: 684},
             %{hand: "QQQJA", value: 6, bid: 483},
             %{hand: "KTJJT", value: 6, bid: 220}
           ]
  end

  test "parses and ranks equal hands with jokers" do
    hands = [
      "JJ111 1",
      "11111 2"
    ]

    ranked_hands =
      hands
      |> Enum.map(&Day07.parse_hand(&1, true))
      |> Enum.sort(fn a, b -> !Day07.hand_a_beats_b(a, b, true) end)

    assert ranked_hands == [
             %{hand: "JJ111", value: 7, bid: 1},
             %{hand: "11111", value: 7, bid: 2}
           ]
  end
end
