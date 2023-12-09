defmodule Day07Test do
  use ExUnit.Case

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

  test "ranks example hands" do
    hands = [
      %{hand: "32T3K", value: 2, bid: 765},
      %{hand: "T55J5", value: 4, bid: 684},
      %{hand: "KK677", value: 3, bid: 28},
      %{hand: "KTJJT", value: 3, bid: 220},
      %{hand: "QQQJA", value: 4, bid: 483}
    ]

    ranked_hands = hands |> Enum.sort(fn a, b -> !Day07.hand_a_beats_b(a, b) end)

    assert ranked_hands == [
             %{hand: "32T3K", value: 2, bid: 765},
             %{hand: "KTJJT", value: 3, bid: 220},
             %{hand: "KK677", value: 3, bid: 28},
             %{hand: "T55J5", value: 4, bid: 684},
             %{hand: "QQQJA", value: 4, bid: 483}
           ]
  end
end
