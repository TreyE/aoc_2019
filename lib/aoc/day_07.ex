defmodule AOC.Day07 do
  def run1() do
   max_phases = AOC.Day07.Amplifier.run_permutations()
   IO.inspect(max_phases)
  end
end
