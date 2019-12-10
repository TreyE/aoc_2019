defmodule AOC.Day07.Amplifier do
  alias AOC.Day07.VmState
  alias AOC.Day07.Input
  alias AOC.Day07.AmplifierSample

  def run_amplifier({phase_setting, input}) do
    vm = VmState.new(Input.parsed_input(), nil, [self()], self())
    rp = spawn(fn -> VmState.wait_init(vm) end)
    send(rp, {:start, nil})
    send(rp, {:input, nil, phase_setting})
    send(rp, {:input, nil, input})
    loop([])
  end

  def loop(output_buffer) do
    receive do
      {:input, _, output} ->  loop([output|output_buffer])
      {:halt, _} -> Enum.at(output_buffer, 0)
    end
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
