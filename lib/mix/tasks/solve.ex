defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run([day, part]) do
    function_name = String.to_atom("day#{day}_part#{part}")
    apply(AdventOfCode, function_name, []) |> IO.inspect(label: "Day #{day} Part #{part}")
  end
end
