defmodule AOC.Day07.AmplifierLoopTest do
  use ExUnit.Case

  test "139629729" do
    input_string = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,
    27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"
    input_program = AOC.Day07.Input.parse_input(input_string)
    phase_perms = AOC.Day07.AmplifierLoop.permutations_for([5,6,7,8,9])
    phase_sums = AOC.Day07.AmplifierLoop.test_phase([9,8,7,6,5], input_program)
    139629729 = Enum.at(phase_sums, 0)
  end
end
