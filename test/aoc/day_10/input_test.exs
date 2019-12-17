defmodule AOC.Day10.InputTest do
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
    true = Enum.member?(items, {0,1})
    true = Enum.member?(items, {9,9})
    true = Enum.member?(items, {9,7})
    40 = Enum.count(items)
  end
end
