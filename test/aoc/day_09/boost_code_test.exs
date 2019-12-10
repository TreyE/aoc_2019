defmodule AOC.Day09.BoostCodeTest do
  use ExUnit.Case

  alias AOC.Day09.Input
  alias AOC.Day09.VmState

  test "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" do
    input_string = "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
    input_program = Input.parse_input(input_string)
    vm = VmState.new(input_program, nil, [self()], self())
    vm_pid = spawn(fn() -> VmState.wait_init(vm) end)
    send(vm_pid, {:start, self()})
    value = loop([])
    [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99] = Enum.reverse(value)
  end

  test "104,1125899906842624,99" do
    input_string = "104,1125899906842624,99"
    input_program = Input.parse_input(input_string)
    vm = VmState.new(input_program, nil, [self()], self())
    vm_pid = spawn(fn() -> VmState.wait_init(vm) end)
    send(vm_pid, {:start, self()})
    value = loop([])
    [1125899906842624] = Enum.reverse(value)
  end

  test "1102,34915192,34915192,7,4,7,99,0" do
    input_string = "1102,34915192,34915192,7,4,7,99,0"
    input_program = Input.parse_input(input_string)
    vm = VmState.new(input_program, nil, [self()], self())
    vm_pid = spawn(fn() -> VmState.wait_init(vm) end)
    send(vm_pid, {:start, self()})
    value = loop([])
    [1219070632396864] = Enum.reverse(value)
  end

  def loop(output_buffer) do
    receive do
      {:halt, _} -> output_buffer
      {:input, _, input_val} -> loop([input_val|output_buffer])
    end
  end
end
