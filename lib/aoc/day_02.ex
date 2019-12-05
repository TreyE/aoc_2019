defmodule AOC.Day02 do
  def run1 do
    input_buffer = AOC.Day02.Input.parsed_input()
    vm_state = AOC.Day02.VmState.new(input_buffer)
    error_code_state = vm_state
                       |> AOC.Day02.VmState.write(1, 12)
                       |> AOC.Day02.VmState.write(2, 2)
    {:halt, vm_result} = AOC.Day02.VmState.run(error_code_state)
    IO.inspect(AOC.Day02.VmState.format(vm_result))
  end

  def run2 do
    vals = for i <- 0..99, j <- 0..99, do:  {i, j}
    {noun, verb} = Enum.reduce_while(vals, 0, fn({a, b}, _) ->
      case attempt_solution(a, b) do
        19690720 -> {:halt, {a, b}}
        _ -> {:cont, 0}
      end
    end)
    total = 100 * noun + verb
    IO.inspect(total)
  end

  def attempt_solution(a, b) do
    input_buffer = AOC.Day02.Input.parsed_input()
    vm_state = AOC.Day02.VmState.new(input_buffer)
    error_code_state = vm_state
                       |> AOC.Day02.VmState.write(1, a)
                       |> AOC.Day02.VmState.write(2, b)
    {:halt, vm_result} = AOC.Day02.VmState.run(error_code_state)
    AOC.Day02.VmState.read(vm_result, 0)
  end
end
