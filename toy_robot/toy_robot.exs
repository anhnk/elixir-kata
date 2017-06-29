usage = """
------------------------------------ USAGE ------------------------------------
Command:         mix run toy_robot.exs [FILE_PATH]
Notes:           The sequence of commands must be on the first line of the file.
                 Any other lines after it will be ignored.
"""

case length(System.argv) do
  1 ->
    [filename | _] = System.argv

    case File.read(filename) do
      {:ok, contents} ->
        contents
        |> CommandHelper.normalize
        |> Simulator.run
        |> IO.puts
      {:error, :enoent} -> IO.puts "\nFile not found\n\n#{usage}"
      {:error, _} -> IO.puts usage
    end
  _ -> IO.puts "\nWrong number of arguments\n\n#{usage}"
end
