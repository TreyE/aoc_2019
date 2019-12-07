defmodule AOC.Day06 do
   def run1() do
    orbits = AOC.Day06.Input.parsed_input()
    orbit_set = AOC.Day06.OrbitSet.build(orbits)
    IO.inspect(AOC.Day06.OrbitSet.count_orbits(orbit_set))
   end

   def run2() do
    orbits = AOC.Day06.Input.parsed_input()
    orbit_set = AOC.Day06.OrbitSet.build(orbits, :undirected)
    IO.inspect(AOC.Day06.OrbitSet.shortest_path_length(orbit_set, "YOU", "SAN") - 2)
   end
end
