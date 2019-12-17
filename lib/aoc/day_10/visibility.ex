defmodule AOC.Day10.Visibility do
  def node_direction_visibility_counts(items) do
    Enum.map(items, fn(node) ->
      directions = Enum.uniq(Enum.map(items -- [node], fn(item) ->
        AOC.Day10.SearchPath.normalized_direction(node, item)
      end))
      {node, Enum.count(directions)}
    end)
  end

  def construct_spinner(coords, origin) do
    coords_map = Map.new()
    angle_distance_map = Enum.reduce(coords, coords_map, fn(cs, acc) ->
       angle = AOC.Day10.SearchPath.angle(origin, cs)
       Map.update(acc, angle, [cs], fn(values) ->
          Enum.sort([cs|values], fn(e1,e2) ->
            AOC.Day10.SearchPath.distance(origin, e1) < AOC.Day10.SearchPath.distance(origin, e2)
          end)
       end)
    end)
    angle_keys = Enum.reverse(Enum.sort(Map.keys(angle_distance_map)))
    IO.inspect(angle_keys)
    spin_entries = Enum.map(angle_keys, fn(k) ->
      AOC.Day10.SpinEntry.new(k, Map.fetch!(angle_distance_map, k))
    end)
    AOC.Day10.Spinner.new(spin_entries)
  end
end
