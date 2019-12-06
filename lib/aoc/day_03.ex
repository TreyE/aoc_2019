defmodule AOC.Day03 do
   def run1 do
    [wire1_directions, wire2_directions] = AOC.Day03.Input.parsed_input()
    wire1 = AOC.Day03.WirePath.build(wire1_directions)
    wire2 = AOC.Day03.WirePath.build(wire2_directions)
    IO.inspect(AOC.Day03.WirePath.closest_intersection_distance({0,0}, wire1, wire2))
   end

   def run2 do
    [wire1_directions, wire2_directions] = AOC.Day03.Input.parsed_input()
    wire1 = AOC.Day03.WirePath.build(wire1_directions)
    wire2 = AOC.Day03.WirePath.build(wire2_directions)
    intersections = AOC.Day03.WirePath.intersections(wire1, wire2)
    distances = Enum.map(intersections, fn(int) ->
      AOC.Day03.WirePath.intersection_delay(int, wire1, wire2)
    end)
    IO.inspect(Enum.min(distances, fn() -> 0 end))
   end
end
