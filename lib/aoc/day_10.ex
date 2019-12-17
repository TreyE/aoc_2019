defmodule AOC.Day10 do

  def run1() do
    {_,_, items} = AOC.Day10.Input.parsed_input()
    visibility_counts = AOC.Day10.Visibility.node_direction_visibility_counts(items)
    {_, seen} = Enum.max_by(visibility_counts, fn({_, counts}) -> counts end)
    IO.inspect(seen)
  end


  def run2() do
    {_,_, items} = AOC.Day10.Input.parsed_input()
    visibility_counts = AOC.Day10.Visibility.node_direction_visibility_counts(items)
    {node, _} = Enum.max_by(visibility_counts, fn({_, counts}) -> counts end)
    spinner = AOC.Day10.Visibility.construct_spinner(items, node)
    starting_spinner = AOC.Day10.Spinner.spin_to_initial(spinner, 3.0 * :math.pi()/2.0)
    IO.inspect(node)
    result = AOC.Day10.Spinner.zap_and_spin_until(
      starting_spinner,
      0,
      fn(zap_result, acc) ->
        case zap_result do
          {:empty, _} -> acc
          {node, _} ->
            IO.inspect(node)
            case (acc + 1) do
              200 -> {:halt, node}
              other -> {:cont, other}
            end
        end
      end
    )
    {x, y} = result
    IO.inspect(x * 100 + y)
  end
end
