defmodule Simulator do
  @initial_state {nil, nil, nil, "REPORT:\n"}     # {x, y, direction, report}

  def run(commands), do: @initial_state |> execute(commands) |> get_report


  defp execute(state, []), do: state
  defp execute(state, [command | rest]), do: Robot.apply(state, command) |> execute(rest)

  defp get_report({_, _, _, report}), do: report
end
