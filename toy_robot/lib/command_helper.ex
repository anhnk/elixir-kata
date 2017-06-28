defmodule CommandHelper do
  def normalize(commands) do
    commands
    |> String.replace(~r/(.*)\n.*/, "\\1")
    |> String.strip
    |> String.upcase
    |> String.replace(~r/\s+/, " ")
    |> String.replace(~r/PLACE\s/, "PLACE")
    |> String.replace(~r/\s*,\s/, ",")
    |> String.split(" ")
  end
end
