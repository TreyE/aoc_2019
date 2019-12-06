defmodule AOC.Day03.WirePath do

  defstruct [
    location_by_index: %{},
    index_by_location: %{},
    length: 0,
    current_location: {0, 0}
  ]

  def intersections(state1, state2) do
    pos_1 = MapSet.new(Map.values(state1.location_by_index))
    pos_2 = MapSet.new(Map.values(state2.location_by_index))
    MapSet.intersection(pos_1, pos_2)
  end

  def intersection_delay(intersection, state1, state2) do
    distance_from_start(state1, intersection) + distance_from_start(state2, intersection)
  end

  def distance_from_start(state, location) do
    indexes_for_location = Map.fetch!(state.index_by_location, location)
    indexes_for_location
    |> Enum.min(fn() -> 0 end)
  end

  def closest_intersection_distance({l_x, l_y}, state1, state2) do
    intersection_set = intersections(state1, state2)
    intersection_set
    |> Enum.map(fn({x, y}) ->
        abs(l_x - x) + abs(l_y - y)
      end)
    |> Enum.min(fn() -> -1 end)
  end

  def build(directions) do
    Enum.reduce(directions, %__MODULE__{}, fn(dir, acc) ->
      move(acc, dir)
    end)
  end

  def move(state, {x, 0}) when x > 0 do
    current_index = state.length
    {current_x, current_y} = state.current_location
    new_location = {current_x + x, current_y}
    location_by_index = Enum.reduce(1..x, state.location_by_index, fn(ele, acc) ->
      Map.put(acc, current_index + ele, {current_x + ele, current_y})
    end)
    index_by_location = Enum.reduce(1..x, state.index_by_location, fn(ele, acc) ->
      val = [current_index + ele]
      Map.update(acc, {current_x + ele, current_y}, val, fn(a) -> a ++ val end)
    end)
    %__MODULE__{
      state |
      length: state.length + x,
      location_by_index: location_by_index,
      index_by_location: index_by_location,
      current_location: new_location
    }
  end

  def move(state, {x, 0}) when x < 0 do
    n_x = -x
    current_index = state.length
    {current_x, current_y} = state.current_location
    new_location = {current_x + x, current_y}
    location_by_index = Enum.reduce(1..n_x, state.location_by_index, fn(ele, acc) ->
      Map.put(acc, current_index + ele, {current_x - ele, current_y})
    end)
    index_by_location = Enum.reduce(1..n_x, state.index_by_location, fn(ele, acc) ->
      val = [current_index + ele]
      Map.update(acc, {current_x - ele, current_y}, val, fn(a) -> a ++ val end)
    end)
    %__MODULE__{
      state |
      length: state.length + n_x,
      location_by_index: location_by_index,
      index_by_location: index_by_location,
      current_location: new_location
    }
  end

  def move(state, {0, y}) when y > 0 do
    current_index = state.length
    {current_x, current_y} = state.current_location
    new_location = {current_x, current_y + y}
    location_by_index = Enum.reduce(1..y, state.location_by_index, fn(ele, acc) ->
      Map.put(acc, current_index + ele, {current_x, current_y + ele})
    end)
    index_by_location = Enum.reduce(1..y, state.index_by_location, fn(ele, acc) ->
      val = [current_index + ele]
      Map.update(acc, {current_x, current_y + ele}, val, fn(a) -> a ++ val end)
    end)
    %__MODULE__{
      state |
      length: state.length + y,
      location_by_index: location_by_index,
      index_by_location: index_by_location,
      current_location: new_location
    }
  end

  def move(state, {0, y}) when y < 0 do
    n_y = -y
    current_index = state.length
    {current_x, current_y} = state.current_location
    new_location = {current_x, current_y + y}
    location_by_index = Enum.reduce(1..n_y, state.location_by_index, fn(ele, acc) ->
      Map.put(acc, current_index + ele, {current_x, current_y - ele})
    end)
    index_by_location = Enum.reduce(1..n_y, state.index_by_location, fn(ele, acc) ->
      val = [current_index + ele]
      Map.update(acc, {current_x, current_y - ele}, val, fn(a) -> a ++ val end)
    end)
    %__MODULE__{
      state |
      length: state.length + n_y,
      location_by_index: location_by_index,
      index_by_location: index_by_location,
      current_location: new_location
    }
  end
end
