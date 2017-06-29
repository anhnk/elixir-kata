defmodule Robot do
  @place_command_regex ~r/PLACE(?<x_pos>\d+),(?<y_pos>\d+),(?<direction>[A-Z]+)/

  def apply({nil, nil, nil, report}, command) do
    case valid_place_cmd?(command) do
      true -> place(report, command)
      false -> {nil, nil, nil, report}
    end
  end

  def apply({x_pos, y_pos, direction, report}, "LEFT"), do: {x_pos, y_pos, Table.left(direction), report}
  def apply({x_pos, y_pos, direction, report}, "RIGHT"), do: {x_pos, y_pos, Table.right(direction), report}
  def apply({x_pos, y_pos, direction, report}, "REPORT"), do: {x_pos, y_pos, direction, "#{report}#{x_pos},#{y_pos},#{atom_to_s(direction)}\n"}
  def apply({x_pos, y_pos, direction, report}, "MOVE") do
    new_position = case direction do
      :north -> {x_pos, y_pos + 1, direction}
      :south -> {x_pos, y_pos - 1, direction}
      :east -> {x_pos + 1, y_pos, direction}
      :west -> {x_pos - 1, y_pos, direction}
    end

    case Table.valid_position?(new_position) do
      true ->
        {new_x_pos, new_y_pos, direction} = new_position
        {new_x_pos, new_y_pos, direction, report}
      false -> {x_pos, y_pos, direction, report}
    end
  end

  def apply({x_pos, y_pos, direction, report}, command) do
    case valid_place_cmd?(command) do
      true -> place(report, command)
      false -> {x_pos, y_pos, direction, report}
    end
  end

  defp place(report, command) do
    {x_pos, y_pos, direction} = get_position(command)
    {x_pos, y_pos, direction, report}
  end

  defp valid_place_cmd?(command) do
    case Regex.match?(@place_command_regex, command) do
      true -> command |> get_position |> Table.valid_position?
      false -> false
    end
  end

  defp get_position(command) do
    %{"x_pos" => x_pos, "y_pos" => y_pos, "direction" => direction} =
      Regex.named_captures(@place_command_regex, command)
    {to_i(x_pos), to_i(y_pos), to_atom(direction)}
  end

  defp to_i(pos), do: String.to_integer(pos)
  defp to_atom(direction), do: direction |> String.downcase |> String.to_atom
  defp atom_to_s(direction), do: direction |> Atom.to_string |> String.upcase
end
