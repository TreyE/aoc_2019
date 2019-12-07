defmodule AOC.Day05 do
  def run1 do
    input_buffer = AOC.Day05.Input.parsed_input()
    vm_state = AOC.Day05.VmState.new(input_buffer)
    vm_with_input = %AOC.Day05.VmState{
      vm_state |
      in_buffer: [1]
    }
    {:halt, _} = AOC.Day05.VmState.run(vm_with_input)
  end

  def run2 do
    input_buffer = AOC.Day05.Input.parsed_input()
    vm_state = AOC.Day05.VmState.new(input_buffer)
    vm_with_input = %AOC.Day05.VmState{
      vm_state |
      in_buffer: [5]
    }
    {:halt, _} = AOC.Day05.VmState.run(vm_with_input)
  end
end
