defmodule PortalTest do
  use ExUnit.Case  

  Portal.shoot(:red)
  Portal.shoot(:blue)

  test "portal creation" do
    portal = Portal.transfer(:red, :blue, [1,2,3])
    assert portal.left  == :red
    assert portal.right == :blue
    assert Portal.Door.get(portal.left) == [3,2,1]

    Portal.Door.empty(portal.left)
    Portal.Door.empty(portal.right)
  end

  test "portal push right" do
    portal = Portal.transfer(:red, :blue, [1,2,3])

    Portal.push_right(portal)
    assert Portal.Door.get(portal.left) == [2,1]
    assert Portal.Door.get(portal.right) == [3]

    Portal.push_right(portal)
    assert Portal.Door.get(portal.left) == [1]
    assert Portal.Door.get(portal.right) == [2,3]

    Portal.Door.empty(portal.left)
    Portal.Door.empty(portal.right)
  end

  test "portal push left" do
    portal = Portal.transfer(:red, :blue, [1,2,3])

    Portal.push_left(portal)
    assert Portal.Door.get(portal.left) == [3,2,1]
    assert Portal.Door.get(portal.right) == []

    Portal.push_right(portal)

    Portal.push_left(portal)
    assert Portal.Door.get(portal.left) == [3,2,1]
    assert Portal.Door.get(portal.right) == []

    Portal.Door.empty(portal.left)
    Portal.Door.empty(portal.right)
  end

  test "portal push all right" do
    portal = Portal.transfer(:red, :blue, [1,2,3])

    Portal.push_all_right(portal)
    assert Portal.Door.get(portal.left) == []
    assert Portal.Door.get(portal.right) == [1,2,3]

    Portal.Door.empty(portal.left)
    Portal.Door.empty(portal.right)
  end

  test "portal push all left" do
    portal = Portal.transfer(:red, :blue, [1,2,3])

    Portal.push_all_right(portal)
    Portal.push_all_left(portal)
    assert Portal.Door.get(portal.left) == [3,2,1]
    assert Portal.Door.get(portal.right) == []

    Portal.Door.empty(portal.left)
    Portal.Door.empty(portal.right)
  end

end
