defmodule TerminalGame do
  def play(_grid, _name, 0), do: :ok
  def play(grid, name, steps) do
    grid
    |> print(name)
    |> Grid.next
    |> play(name, steps - 1)
  end

  defp print(grid, name) do
    IO.puts(String.duplicate("\n", 100))
    IO.puts("#{name}\n")

    for y <- 0..(Grid.size(grid) - 1) do
      for x <- 0..(Grid.size(grid) - 1) do
        case Grid.cell_status(grid, x, y) do
          0 -> IO.write(" ")
          1 -> IO.write("*")
        end
      end
      IO.puts("")
    end
    :timer.sleep(200)
    grid
  end
end
