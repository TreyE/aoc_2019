defmodule AOC.Day07 do
  def run1() do
   max_phases = AOC.Day07.Amplifier.run_permutations()
   IO.inspect(max_phases)
  end

  def run2() do
    phase_perms = AOC.Day07.AmplifierLoop.permutations_for([5,6,7,8,9])
    phase_sums = Enum.map(phase_perms, fn(phases) ->
      Enum.at(AOC.Day07.AmplifierLoop.collect_sample(phases), 0)
    end)
    IO.inspect(Enum.max(phase_sums))
  end
end
