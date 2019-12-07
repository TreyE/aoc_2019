defmodule AOC.Day02.OpCode do
  defstruct [
    code: 99,
    width: 1,
    function: :halt
  ]

  def new(code, width, func) do
    %__MODULE__{
      code: code,
      width: width,
      function: func
    }
  end

  def add(state) do
    operand_1_location = Map.fetch!(state.memory_buffer, state.current_index + 1)
    operand_2_location = Map.fetch!(state.memory_buffer, state.current_index + 2)
    output_location = Map.fetch!(state.memory_buffer, state.current_index + 3)
    operand_1 = Map.fetch!(state.memory_buffer, operand_1_location)
    operand_2 = Map.fetch!(state.memory_buffer, operand_2_location)
    AOC.Day02.VmState.write(state, output_location, operand_1 + operand_2)
  end

  def multi(state) do
    operand_1_location = Map.fetch!(state.memory_buffer, state.current_index + 1)
    operand_2_location = Map.fetch!(state.memory_buffer, state.current_index + 2)
    output_location = Map.fetch!(state.memory_buffer, state.current_index + 3)
    operand_1 = Map.fetch!(state.memory_buffer, operand_1_location)
    operand_2 = Map.fetch!(state.memory_buffer, operand_2_location)
    AOC.Day02.VmState.write(state, output_location, operand_1 * operand_2)
  end
end
