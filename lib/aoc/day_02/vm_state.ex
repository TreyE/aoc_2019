defmodule AOC.Day02.VmState do
  defstruct [
    current_index: 0,
    memory_buffer: %{}
  ]

  def new(buffer) do
    mapped = Enum.with_index(buffer)
    m_buffer = Enum.reduce(mapped, %{}, fn({e, i}, acc) ->
      Map.put(acc, i, e)
    end)
    %__MODULE__{
      memory_buffer: m_buffer
    }
  end

  def run(state) do
    case next(state) do
      {:cont, new_state} -> run(new_state)
      other -> other
    end
  end

  def format(state) do
    state.memory_buffer
    |> Map.keys()
    |> Enum.sort()
    |> Enum.map(fn(ele) ->
      Integer.to_string(Map.fetch!(state.memory_buffer, ele))
    end)
    |> Enum.join(",")
  end

  def next(state) do
    op_code = Map.fetch!(state.memory_buffer, state.current_index)
    case op_code do
      99 -> {:halt, state}
      _ -> execute(state, op_code)
    end
  end

  def execute(state, op_code) do
    operand_1_location = Map.fetch!(state.memory_buffer, state.current_index + 1)
    operand_2_location = Map.fetch!(state.memory_buffer, state.current_index + 2)
    output_location = Map.fetch!(state.memory_buffer, state.current_index + 3)
    operand_1 = Map.fetch!(state.memory_buffer, operand_1_location)
    operand_2 = Map.fetch!(state.memory_buffer, operand_2_location)
    case op_code do
      1 ->
        new_state = state
                    |> write(output_location, operand_1 + operand_2)
                    |> move_index(4)
        {:cont, new_state}
      2 ->
        new_state = state
                    |> write(output_location, operand_1 * operand_2)
                    |> move_index(4)
        {:cont, new_state}
      _ -> {:halt, {:error_unknown_opcode, op_code, state}}
    end
  end

  def write(state, location, value) do
    updated_buffer = Map.put(state.memory_buffer, location, value)
    %__MODULE__{
      state |
      memory_buffer: updated_buffer
    }
  end

  def read(state, location) do
    Map.fetch!(state.memory_buffer, location)
  end

  def move_index(state, offset) do
    %__MODULE__{
      state |
      current_index: (state.current_index + offset)
    }
  end
end
