defmodule RobotTest do
  use ExUnit.Case

  describe "not placed yet" do
    test "returns new position" do
      assert Robot.apply({nil, nil, nil, "report"}, "PLACE3,4,EAST") == {3, 4, :east, "report"}
      assert Robot.apply({nil, nil, nil, "report"}, "PLACE0,2,NORTH") == {0, 2, :north, "report"}
      assert Robot.apply({nil, nil, nil, "report"}, "LEFT") == {nil, nil, nil, "report"}
      assert Robot.apply({nil, nil, nil, "report"}, "RIGHT") == {nil, nil, nil, "report"}
      assert Robot.apply({nil, nil, nil, "report"}, "MOVE") == {nil, nil, nil, "report"}
      assert Robot.apply({nil, nil, nil, "report"}, "REPORT") == {nil, nil, nil, "report"}
    end
  end

  describe "placed" do
    test "returns new position" do
      assert Robot.apply({2, 2, :north, "report"}, "PLACE3,4,EAST") == {3, 4, :east, "report"}
      assert Robot.apply({2, 2, :north, "report"}, "PLACE0,2,NORTH") == {0, 2, :north, "report"}
      assert Robot.apply({2, 2, :north, "report"}, "LEFT") == {2, 2, :west, "report"}
      assert Robot.apply({2, 2, :north, "report"}, "RIGHT") == {2, 2, :east, "report"}
      assert Robot.apply({2, 2, :north, "report"}, "MOVE") == {2, 3, :north, "report"}
      assert Robot.apply({4, 3, :north, "report"}, "MOVE") == {4, 4, :north, "report"}
      assert Robot.apply({4, 3, :east, "report"}, "MOVE") == {4, 3, :east, "report"}
      assert Robot.apply({3, 4, :north, "report"}, "MOVE") == {3, 4, :north, "report"}
      assert Robot.apply({2, 2, :north, "report"}, "REPORT") == {2, 2, :north, "report2,2,NORTH\n"}
    end
  end
end
