defmodule Simulator do
  @usage """
  ------------------------------------ USAGE ------------------------------------
  Command:         mix run toy_robot.exs [FILE_PATH]
  Notes:           The sequence of commands must be on the first line of the file.
                   Any other lines after it will be ignored.
  """
  @wrong_number_of_args_error "\nWrong number of arguments\n\n#{@usage}"
  @initial_state {nil, nil, nil, "REPORT:\n"}     # {x, y, direction, report}

  def run([]), do: @wrong_number_of_args_error
  def run(args) when length(args) > 1, do: @wrong_number_of_args_error
  def run(filename) do
    case read_file_and_execute(filename) do
      {:ok, report} -> report
      {:error, _} -> "Can't read file"
    end
  end

  defp read_file_and_execute(filename) do
    with {:ok, contents}   <- File.read(filename),
         commands          <- CommandHelper.normalize(contents),
         {_, _, _, report} <- execute(@initial_state, commands),
         do: {:ok, report}
  end

  defp execute(state, []), do: state
  defp execute(state, [command | rest]), do: Robot.apply(state, command) |> execute(rest)
end
