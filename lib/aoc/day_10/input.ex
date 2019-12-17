defmodule AOC.Day10.Input do
  @input ".###.#...#.#.##.#.####..
  .#....#####...#.######..
  #.#.###.###.#.....#.####
  ##.###..##..####.#.####.
  ###########.#######.##.#
  ##########.#########.##.
  .#.##.########.##...###.
  ###.#.##.#####.#.###.###
  ##.#####.##..###.#.##.#.
  .#.#.#####.####.#..#####
  .###.#####.#..#..##.#.##
  ########.##.#...########
  .####..##..#.###.###.#.#
  ....######.##.#.######.#
  ###.####.######.#....###
  ############.#.#.##.####
  ##...##..####.####.#..##
  .###.#########.###..#.##
  #.##.#.#...##...#####..#
  ##.#..###############.##
  ##.###.#####.##.######..
  ##.#####.#.#.##..#######
  ...#######.######...####
  #....#.#.#.####.#.#.#.##"

  def parsed_input do
    parse_input(@input)
  end

  def parse_input(input_string) do
    input_lines = String.split(input_string, "\n", trim: true)
    max_y = Enum.count(input_lines) - 1
    max_x = String.length(Enum.at(input_lines,0)) - 1
    indexed_lines = Enum.with_index(input_lines)
    coords =  Enum.flat_map(indexed_lines, fn({line, idx}) ->
      split_line(String.trim(line), idx)
    end)
    {max_x, max_y, coords}
  end

  def split_line(line, index) do
    lines_with_index = Enum.with_index(String.codepoints(line))
    lines_with_items = Enum.reject(lines_with_index, fn({e,_}) ->
      "." == e
    end)
    Enum.map(
      lines_with_items,
      fn({_, idx}) ->
        {idx, index}
      end
    )
  end
end
