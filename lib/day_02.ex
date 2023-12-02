defmodule Day02 do
  defmodule Round do
    defstruct red: 0, green: 0, blue: 0
  end

  @expected_game struct(Round, %{red: 12, green: 13, blue: 14})

  @doc """
  ## Example

      iex> Day02.is_valid_game_record("Game 1: 1 red, 1 green, 1 blue")
      true

      iex> Day02.is_valid_game_record("Game 2: 999 red")
      false

      iex> Day02.is_valid_game_record("Game 3: 12 red, 13 green, 14 blue")
      true

      iex> Day02.is_valid_game_record("Game 400: 1 red; 13 green, 99 blue")
      false
  """
  def is_valid_game_record(game_record) do
    game_record
    |> parse_game_record
    |> Enum.map(&(&1 |> parse_round |> is_valid_round))
    |> Enum.all?()
  end

  @doc """
  ## Example

      iex> Day02.get_game_record_power("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
      48
  """
  def get_game_record_power(game_record) do
    game_record
    |> parse_game_record
    |> Enum.map(&parse_round/1)
    |> Enum.reduce(fn round, acc -> Map.merge(acc, round, fn _, a, b -> max(a, b) end) end)
    |> get_round_power
  end

  @doc """
  ## Example

      iex> Day02.parse_game_id("Game 123: 1 red, 1 green, 1 blue")
      123
  """
  def parse_game_id(game_record) do
    {id, _} = Regex.named_captures(~r/Game (?<id>\d+):/, game_record)["id"] |> Integer.parse()
    id
  end

  @doc """
  ## Example

      iex> Day02.parse_round("1 red, 2 green, 3 blue")
      %{red: 1, green: 2, blue: 3}

      iex> Day02.parse_round("123 red, 321 blue")
      %{red: 123, green: 0, blue: 321}

      iex> Day02.parse_round("21 green")
      %{red: 0, green: 21, blue: 0}
  """
  defp parse_round(round) do
    struct(
      Round,
      for item <- String.split(round, ", "), into: %{} do
        %{"amount" => amount, "colour" => colour} =
          Regex.named_captures(~r/(?<amount>\d+) (?<colour>red|green|blue)/, item)

        {String.to_atom(colour), amount |> Integer.parse() |> elem(0)}
      end
    )
  end

  defp is_valid_round(%{red: red, green: green, blue: blue}) do
    red <= @expected_game.red and green <= @expected_game.green and blue <= @expected_game.blue
  end

  defp parse_game_record(game_record) do
    [_, rounds] = Regex.run(~r/Game \d+: (.+)/, game_record)
    String.split(rounds, "; ")
  end

  defp get_round_power(%{red: red, green: green, blue: blue}) do
    red * green * blue
  end
end
