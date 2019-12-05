defmodule AOC.Day02.IntCodeTest do
  use ExUnit.Case

  test "1,0,0,0,99" do
    "2,0,0,0,99" = run_vm("1,0,0,0,99")
  end

  test "2,3,0,3,99" do
    "2,3,0,6,99" = run_vm("2,3,0,3,99")
  end

  test "2,4,4,5,99,0" do
    "2,4,4,5,99,9801" = run_vm("2,4,4,5,99,0")
  end

  test "1,1,1,4,99,5,6,0,99" do
    "30,1,1,4,2,5,6,0,99" = run_vm("1,1,1,4,99,5,6,0,99")
  end

  defp run_vm(input_string) do
    input_buffer = AOC.Day02.Input.parse_input(input_string)
    vm_state = AOC.Day02.VmState.new(input_buffer)
    {:halt, vm_result} = AOC.Day02.VmState.run(vm_state)
    AOC.Day02.VmState.format(vm_result)
  end
end
