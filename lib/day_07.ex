defmodule Day07 do
  def parse_hand(<<hand::binary-size(5), " ", bid::binary>>) do
    {parsed_bid, _} = Integer.parse(bid)
    %{hand: hand, value: get_hand_value(hand), bid: parsed_bid}
  end

  def hand_a_beats_b(%{hand: hand_a, value: value_a}, %{hand: hand_b, value: value_b}) do
    cond do
      value_a === value_b -> equal_hand_a_beats_b(hand_a, hand_b)
      true -> value_a > value_b
    end
  end

  defp equal_hand_a_beats_b("", ""), do: true

  defp equal_hand_a_beats_b(
         <<card_a::binary-size(1), hand_a::binary>>,
         <<card_b::binary-size(1), hand_b::binary>>
       ) do
    value_a = get_card_value(card_a)
    value_b = get_card_value(card_b)

    cond do
      value_a == value_b -> equal_hand_a_beats_b(hand_a, hand_b)
      true -> value_a > value_b
    end
  end

  defp get_hand_value(hand) do
    frequencies =
      hand
      |> String.graphemes()
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort(fn a, b -> a >= b end)

    case frequencies do
      [5] -> 7
      [4 | _] -> 6
      [3, 2] -> 5
      [3 | _] -> 4
      [2, 2 | _] -> 3
      [2 | _] -> 2
      _ -> 1
    end
  end

  defp get_card_value(card) do
    case card do
      "A" ->
        14

      "K" ->
        13

      "Q" ->
        12

      "J" ->
        11

      "T" ->
        10

      rest ->
        {parsed, _} = Integer.parse(rest)
        parsed
    end
  end
end
