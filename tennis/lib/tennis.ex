defmodule PointSystem do
  defmacro won_by_2_points(winner_points, loser_points) do
    quote do: (unquote(loser_points) >= 3) and (unquote(winner_points) - unquote(loser_points) == 2)
  end
end

defmodule Tennis do
  import PointSystem

  @tennis_score ["Love", "15", "30", "40"]

  def scores(pts, pts) when pts > 2, do: "Deuce"
  def scores(pts, pts), do: score(pts) <> " all"

  def scores(p1_pts, 0) when p1_pts < 4, do: score(p1_pts) <> " love"
  def scores(0, p2_pts) when p2_pts < 4, do: "Love " <> score(p2_pts)

  def scores(4, p2_pts) when p2_pts < 3, do: "Game player 1"
  def scores(p1_pts, 4) when p1_pts < 3, do: "Game player 2"
  def scores(p1_pts, p2_pts) when won_by_2_points(p1_pts, p2_pts), do: "Game player 1"
  def scores(p1_pts, p2_pts) when won_by_2_points(p2_pts, p1_pts), do: "Game player 2"

  def scores(p1_pts, p2_pts) when p1_pts - p2_pts == 1, do: "Advantage player 1"
  def scores(p1_pts, p2_pts) when p1_pts - p2_pts == -1, do: "Advantage player 2"


  defp score(pts), do: Enum.at(@tennis_score, pts)
end
