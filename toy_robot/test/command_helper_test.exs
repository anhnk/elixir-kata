defmodule CommandHelperTest do
  use ExUnit.Case

  describe "CommandHelper.normalize/1" do
    test "removes everything after the first line" do
      assert CommandHelper.normalize("FIRST LINE\nSECOND LINE\nTHIRD LINE") == ~w/FIRST LINE/
    end

    test "trims whitespaces" do
      assert CommandHelper.normalize(" LEFT  ") == ~w/LEFT/
    end

    test "upcases all letters" do
      assert CommandHelper.normalize("left") == ~w/LEFT/
    end

    test "replaces multiple consecutive whitespaces with 1 whitespace" do
      assert CommandHelper.normalize("LEFT  RIGHT") == ~w/LEFT RIGHT/
    end

    test "removes whitespaces in PLACE command" do
      assert CommandHelper.normalize("PLACE 3 , 4, NORTH") == ~w/PLACE3,4,NORTH/
    end

    test "normalizes and returns arrays" do
      assert CommandHelper.normalize("  RiGht  PLACE  3, 4 , NOrTH   LeFT MOve   REPORT") == ~w/RIGHT PLACE3,4,NORTH LEFT MOVE REPORT/
    end
  end
end
