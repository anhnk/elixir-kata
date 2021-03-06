defmodule SimulatorTest do
  use ExUnit.Case

  test "returns report for data1" do
    report = Simulator.run("data/data1.txt")
    expected = "REPORT:\n2,4,WEST\n"

    assert report == expected
  end

  test "returns report for data2" do
    report = Simulator.run("data/data2.txt")
    expected = "REPORT:\n3,3,SOUTH\n0,3,WEST\n"

    assert report == expected
  end

  test "returns report for data3" do
    report = Simulator.run("data/data3.txt")
    expected = "REPORT:\n3,3,NORTH\n3,1,SOUTH\n3,1,WEST\n"

    assert report == expected
  end

  test "returns report for data4" do
    report = Simulator.run("data/data4.txt")
    expected = "REPORT:\n"

    assert report == expected
  end
end
