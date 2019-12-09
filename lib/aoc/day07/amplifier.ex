defmodule AOC.Day07.Amplifier do
  alias AOC.Day07.VmState
  alias AOC.Day07.Input
  alias AOC.Day07.AmplifierSample

  def run_amplifier({phase_setting, input}) do
    vm = VmState.new(Input.parsed_input(), [phase_setting, input])
    {:halt, vm_result} = VmState.run(vm)
    [amplitude|_] = vm_result.output_buffer
    amplitude
  end

  def permute_and_run_samples(samples) do
    full_permutations = Enum.flat_map(samples, fn(sample) ->
       AmplifierSample.permute(sample)
    end)
    Enum.map(full_permutations, fn(permu) ->
      amplitude = run_amplifier(permu.current_input)
      AmplifierSample.store_result(permu, amplitude)
    end)
  end

  def run_permutations() do
    first_amp = AmplifierSample.new(0)
    all_results = Enum.reduce(
      1..5,
      [first_amp],
      fn(_, acc) ->
        permute_and_run_samples(acc)
      end
    )
    max_amp = Enum.max_by(all_results, fn(e) ->
      e.last_output
    end)
    max_amp.last_output
  end
end
