defmodule TableTest do
  use ExUnit.Case

  describe "coordinates and direction" do
    test "valid" do
      assert Table.valid_position?({2, 3, :east})
    end

    test "invalid" do
      refute Table.valid_position?({5, 2, :east})
      refute Table.valid_position?({3, 2, "east"})
    end
  end

  describe "coordinates" do
    test "valid" do
      assert Table.valid_coordinates?(0, 0)
      assert Table.valid_coordinates?(1, 2)
      assert Table.valid_coordinates?(3, 4)
    end

    test "invalid" do
      refute Table.valid_coordinates?(0, -1)
      refute Table.valid_coordinates?(0, 5)
      refute Table.valid_coordinates?(5, 2)
      refute Table.valid_coordinates?(5, 6)
    end
  end

  describe "direction" do
    test "valid" do
      assert Table.valid_direction?(:north)
      assert Table.valid_direction?(:east)
      assert Table.valid_direction?(:south)
      assert Table.valid_direction?(:west)
    end

    test "invalid" do
      refute Table.valid_direction?(:south_east)
      refute Table.valid_direction?("north")
    end
  end

  describe "orientation" do
    test "turning left" do
      assert Table.left(:north) == :west
      assert Table.left(:west) == :south
      assert Table.left(:south) == :east
      assert Table.left(:east) == :north
    end

    test "turning right" do
      assert Table.right(:north) == :east
      assert Table.right(:west) == :north
      assert Table.right(:south) == :west
      assert Table.right(:east) == :south
    end
  end
end
