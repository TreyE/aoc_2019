defmodule AOC.Day07.AmplifierSample do
  defstruct [
    history: [],
    remaining_phases: [0,1,2,3,4],
    last_output: nil,
    current_input: nil
  ]

  def new(last_output) do
    %__MODULE__{
      last_output: last_output
    }
  end

  def permute(a_sample) do
    remaining_phases = a_sample.remaining_phases
    Enum.map(a_sample.remaining_phases, fn(phase) ->
      leftover_phases = remaining_phases -- [phase]
      %__MODULE__{
        history: a_sample.history,
        remaining_phases: leftover_phases,
        current_input: {phase, a_sample.last_output}
      }
    end)
  end

  def store_result(a_sample, output) do
    {input_phase, last_input} = a_sample.current_input
    %__MODULE__{
      a_sample |
      history: [{input_phase, last_input, output}|a_sample.history],
      last_output: output
    }
  end

  def phases(a_sample) do
    Enum.reduce(a_sample.history, [], fn(h_entry, acc) ->
      {i_phase, _, _} = h_entry
      [i_phase|acc]
    end)
  end
end
