defmodule DoorTest do
  use ExUnit.Case

  test "door creation" do
    Portal.Door.start_link(:color)
    assert Portal.Door.get(:color) == []
  end

  test "door push" do
    Portal.Door.start_link(:color)
    Portal.Door.push(:color, 2)
    assert Portal.Door.get(:color) == [2]
    Portal.Door.push(:color, 1)
    assert Portal.Door.get(:color) == [1, 2]
  end

  test "door pop" do
    Portal.Door.start_link(:color)

    Portal.Door.push(:color, 2)
    Portal.Door.push(:color, 1)
    assert Portal.Door.pop(:color) == {:ok, 1}
    assert Portal.Door.get(:color) == [2]
  end

  test "door empty" do
    Portal.Door.start_link(:color)
    Portal.Door.push(:color, 2)
    Portal.Door.push(:color, 1)
    Portal.Door.empty(:color)
    assert Portal.Door.get(:color) == []
  end

end
