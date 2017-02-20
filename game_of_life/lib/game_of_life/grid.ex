defmodule Grid do
  defstruct data: nil

  def new(size) when is_integer(size) and size > 0 do
    %Grid{
      data: new_data(size, fn(_, _) -> :rand.uniform(2) - 1 end)
    }
  end

  def new(data) when is_list(data) do
    %Grid{data: list_to_data(data)}
  end

  def size(%Grid{data: data}), do: tuple_size(data)

  def cell_status(grid, x, y) do
    grid.data
    |> elem(y)
    |> elem(x)
  end

  def next(grid) do
    %Grid{grid |
      data: new_data(size(grid), &next_cell_status(grid, &1, &2))
    }
  end

  defp new_data(size, producer_fun) do
    for y <- 0..(size - 1) do
      for x <- 0..(size - 1) do
        producer_fun.(x, y)
      end
    end
    |> list_to_data
  end

  defp list_to_data(data) do
    data
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple
  end

  def next_cell_status(grid, x, y) do
    case {cell_status(grid, x, y), alive_neighbours(grid, x, y)} do
      {1, 2} -> 1
      {1, 3} -> 1
      {0, 3} -> 1
      {_, _} -> 0
    end
  end

  defp alive_neighbours(grid, cell_x, cell_y) do
    for x <- (cell_x - 1)..(cell_x + 1),
        y <- (cell_y - 1)..(cell_y + 1),
        (
          x in 0..(size(grid) - 1) and
          y in 0..(size(grid) - 1) and
          (x != cell_x or y != cell_y) and
          cell_status(grid, x, y) == 1
        ),
        into: %Sum{}
    do
      1
    end
    |> Sum.value
  end
end
