defmodule AOC.Day03.ShortestWireDistanceTest do
  use ExUnit.Case

  test "part 1 - example 1 - 159" do
    input = "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
    [wire1_directions, wire2_directions] = AOC.Day03.Input.read_wire_instructions(input)
    wire1 = AOC.Day03.WirePath.build(wire1_directions)
    wire2 = AOC.Day03.WirePath.build(wire2_directions)
    159 = AOC.Day03.WirePath.closest_intersection_distance({0,0}, wire1, wire2)
  end

  test "part 1 - example 2 - 135" do
    input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    [wire1_directions, wire2_directions] = AOC.Day03.Input.read_wire_instructions(input)
    wire1 = AOC.Day03.WirePath.build(wire1_directions)
    wire2 = AOC.Day03.WirePath.build(wire2_directions)
    135 = AOC.Day03.WirePath.closest_intersection_distance({0,0}, wire1, wire2)
  end

  test "part 2 - example 1 - 610" do
    input = "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
    [wire1_directions, wire2_directions] = AOC.Day03.Input.read_wire_instructions(input)
    wire1 = AOC.Day03.WirePath.build(wire1_directions)
    wire2 = AOC.Day03.WirePath.build(wire2_directions)
    intersections = AOC.Day03.WirePath.intersections(wire1, wire2)
    distances = Enum.map(intersections, fn(int) ->
      AOC.Day03.WirePath.intersection_delay(int, wire1, wire2)
    end)
    610 = Enum.min(distances, fn() -> 0 end)
  end

  test "part 2 - example 1 - 410" do
    input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    [wire1_directions, wire2_directions] = AOC.Day03.Input.read_wire_instructions(input)
    wire1 = AOC.Day03.WirePath.build(wire1_directions)
    wire2 = AOC.Day03.WirePath.build(wire2_directions)
    intersections = AOC.Day03.WirePath.intersections(wire1, wire2)
    distances = Enum.map(intersections, fn(int) ->
      AOC.Day03.WirePath.intersection_delay(int, wire1, wire2)
    end)
    410 = Enum.min(distances, fn() -> 0 end)
  end
end
