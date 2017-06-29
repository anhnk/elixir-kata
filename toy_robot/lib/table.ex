defmodule Table do
  @cols 5
  @rows 5
  @right_orientations %{north: :east, east: :south, south: :west, west: :north}

  def valid_position?({x_pos, y_pos, direction}) do
    valid_coordinates?(x_pos, y_pos) and valid_direction?(direction)
  end

  def valid_coordinates?(x_pos, _) when x_pos < 0, do: false
  def valid_coordinates?(x_pos, _) when x_pos >= @cols, do: false
  def valid_coordinates?(_, y_pos) when y_pos < 0, do: false
  def valid_coordinates?(_, y_pos) when y_pos >= @rows, do: false
  def valid_coordinates?(_, _), do: true

  def valid_direction?(direction) do
    @right_orientations
    |> Map.keys
    |> Enum.member?(direction)
  end

  def left(direction), do: invert(@right_orientations)[direction]
  def right(direction), do: @right_orientations[direction]

  def invert(map) do
    for {key, value} <- map, into: %{}, do: {value, key}
  end
end
