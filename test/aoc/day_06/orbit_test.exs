defmodule AOC.Day06.OrbitTest do
  use ExUnit.Case

  test "parse example" do
    input = "COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L"
    orbits = AOC.Day06.Input.parse_input(input)
    orbit_set = AOC.Day06.OrbitSet.build(orbits)
    42 = AOC.Day06.OrbitSet.count_orbits(orbit_set)
  end
end
