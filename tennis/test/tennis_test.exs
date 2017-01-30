defmodule TennisTest do
  use ExUnit.Case
  doctest Tennis

  test "something all" do
    assert Tennis.scores(0, 0) == "Love all"
    assert Tennis.scores(1, 1) == "15 all"
    assert Tennis.scores(2, 2) == "30 all"
  end

  test "deuce" do
    assert Tennis.scores(3, 3) == "Deuce"
    assert Tennis.scores(4, 4) == "Deuce"
    assert Tennis.scores(5, 5) == "Deuce"
    assert Tennis.scores(12, 12) == "Deuce"
  end

  test "something love" do
    assert Tennis.scores(1, 0) == "15 love"
    assert Tennis.scores(2, 0) == "30 love"
    assert Tennis.scores(3, 0) == "40 love"
  end

  test "love something" do
    assert Tennis.scores(0, 1) == "Love 15"
    assert Tennis.scores(0, 2) == "Love 30"
    assert Tennis.scores(0, 3) == "Love 40"
  end

  test "game" do
    assert Tennis.scores(4, 0) == "Game player 1"
    assert Tennis.scores(4, 1) == "Game player 1"
    assert Tennis.scores(4, 2) == "Game player 1"
    assert Tennis.scores(5, 3) == "Game player 1"
    assert Tennis.scores(12, 10) == "Game player 1"

    assert Tennis.scores(0, 4) == "Game player 2"
    assert Tennis.scores(1, 4) == "Game player 2"
    assert Tennis.scores(2, 4) == "Game player 2"
    assert Tennis.scores(3, 5) == "Game player 2"
    assert Tennis.scores(10, 12) == "Game player 2"
  end

  test "advantage" do
    assert Tennis.scores(4, 3) == "Advantage player 1"
    assert Tennis.scores(5, 4) == "Advantage player 1"
    assert Tennis.scores(12, 11) == "Advantage player 1"

    assert Tennis.scores(3, 4) == "Advantage player 2"
    assert Tennis.scores(4, 5) == "Advantage player 2"
    assert Tennis.scores(11, 12) == "Advantage player 2"
  end
end
