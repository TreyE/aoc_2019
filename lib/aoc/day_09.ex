defmodule AOC.Day09 do
  alias AOC.Day09.Input
  alias AOC.Day09.VmState

  def run1() do
    input_program = Input.parsed_input()
    vm = VmState.new(input_program, 12345, [self()], self())
    vm_pid = spawn(fn() -> VmState.wait_init(vm) end)
    send(vm_pid, {:start, self()})
    send(vm_pid, {:input, self(), 1})
    value = loop([])
    IO.inspect(value)
  end

  def run2() do
    input_program = Input.parsed_input()
    vm = VmState.new(input_program, 12345, [self()], self())
    vm_pid = spawn(fn() -> VmState.wait_init(vm) end)
    send(vm_pid, {:start, self()})
    send(vm_pid, {:input, self(), 2})
    value = loop([])
    IO.inspect(Enum.reverse(value))
  end

  def loop(output_buffer) do
    receive do
      {:halt, 12345} ->
        output_buffer
      {:input, _, input_val} -> loop([input_val|output_buffer])
    end
  end
end
