defmodule AOC.Day07.AmplifierLoop do
  alias AOC.Day07.VmState
  alias AOC.Day07.Input

  def initialize_and_start_vms(phases, input) do
    new_vm_pids = Enum.map(1..5, fn(vm_id) ->
      vm = VmState.new(input, vm_id, [], self())
      spawn(fn() -> VmState.wait_init(vm) end)
    end)
    send(Enum.at(new_vm_pids, 0), {:set_output, [Enum.at(new_vm_pids, 1)]})
    send(Enum.at(new_vm_pids, 1), {:set_output, [Enum.at(new_vm_pids, 2)]})
    send(Enum.at(new_vm_pids, 2), {:set_output, [Enum.at(new_vm_pids, 3)]})
    send(Enum.at(new_vm_pids, 3), {:set_output, [Enum.at(new_vm_pids, 4)]})
    send(Enum.at(new_vm_pids, 4), {:set_output, [Enum.at(new_vm_pids, 0), self()]})
    kick_off_vm(new_vm_pids, 0, phases)
    kick_off_vm(new_vm_pids, 1, phases)
    kick_off_vm(new_vm_pids, 2, phases)
    kick_off_vm(new_vm_pids, 3, phases)
    kick_off_vm(new_vm_pids, 4, phases)
    send(Enum.at(new_vm_pids, 0), {:input, self(), 0})
  end

  def loop([], op) do
    op
  end

  def loop(remaining_ids, output_buffer) do
    receive do
      {:halt, vm_id} -> loop(remaining_ids -- [vm_id], output_buffer)
      {:input, _, input_val} -> loop(remaining_ids, [input_val|output_buffer])
    end
  end

  def collect_sample(phases) do
    test_phase(phases, Input.parsed_input())
  end

  def test_phase(phases, input) do
    initialize_and_start_vms(phases, input)
    loop([1,2,3,4,5], [])
  end

  defp kick_off_vm(vm_pids, index, phases) do
    send(Enum.at(vm_pids, index), {:start, nil})
    send(Enum.at(vm_pids, index), {:input, self(), Enum.at(phases, index)})
  end

  def permutations_for([]) do
    [[]]
  end

  def permutations_for(list) do
    for h <- list, tail <- permutations_for(list -- [h]), do: [h|tail]
  end
end
