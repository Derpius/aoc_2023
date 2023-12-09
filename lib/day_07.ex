defmodule Day07 do
  def parse_hand(<<hand::binary-size(5), " ", bid::binary>>, use_jokers \\ false) do
    {parsed_bid, _} = Integer.parse(bid)
    %{hand: hand, value: get_hand_value(hand, use_jokers), bid: parsed_bid}
  end

  def hand_a_beats_b(
        %{hand: hand_a, value: value_a},
        %{hand: hand_b, value: value_b},
        use_jokers \\ false
      ) do
    cond do
      value_a === value_b -> equal_hand_a_beats_b(hand_a, hand_b, use_jokers)
      true -> value_a > value_b
    end
  end

  defp equal_hand_a_beats_b("", "", _), do: true

  defp equal_hand_a_beats_b(
         <<card_a::binary-size(1), hand_a::binary>>,
         <<card_b::binary-size(1), hand_b::binary>>,
         use_jokers
       ) do
    value_a = get_card_value(card_a, use_jokers)
    value_b = get_card_value(card_b, use_jokers)

    cond do
      value_a == value_b -> equal_hand_a_beats_b(hand_a, hand_b, use_jokers)
      true -> value_a > value_b
    end
  end

  defp get_hand_value(hand, use_jokers) do
    frequencies =
      hand
      |> String.graphemes()
      |> Enum.frequencies()

    with_optional_jokers =
      if use_jokers do
        num_jokers = Map.get(frequencies, "J", 0)

        {common_card, count} =
          Enum.reduce(frequencies, fn {card, count}, {acc_card, acc_count} ->
            if (count > acc_count && card !== "J") || acc_card === "J",
              do: {card, count},
              else: {acc_card, acc_count}
          end)

        if common_card === "J",
          do: frequencies,
          else: Map.merge(frequencies, %{"J" => 0, common_card => count + num_jokers})
      else
        frequencies
      end

    case with_optional_jokers
         |> Map.values()
         |> Enum.sort(fn a, b -> a >= b end) do
      [5 | _] -> 7
      [4 | _] -> 6
      [3, 2 | _] -> 5
      [3 | _] -> 4
      [2, 2 | _] -> 3
      [2 | _] -> 2
      _ -> 1
    end
  end

  defp get_card_value(card, use_jokers) do
    case card do
      "A" ->
        14

      "K" ->
        13

      "Q" ->
        12

      "J" ->
        if use_jokers, do: 0, else: 11

      "T" ->
        10

      rest ->
        {parsed, _} = Integer.parse(rest)
        parsed
    end
  end
end
