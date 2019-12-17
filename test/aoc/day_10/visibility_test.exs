defmodule AOC.Day10.VisibilityTest do
  use ExUnit.Case

  test "7x7" do
    input_string = "......#.#.
#..#.#....
..#######.
.#.#.###..
.#..#.....
..#....#.#
#..#....#.
.##.#..###
##...#..#.
.#....####"
    {9,9, items} = AOC.Day10.Input.parse_input(input_string)
    visibility_counts = AOC.Day10.Visibility.node_direction_visibility_counts(items)
    {{5, 8}, 33} = Enum.max_by(visibility_counts, fn({a, counts}) -> counts end)
  end
end
