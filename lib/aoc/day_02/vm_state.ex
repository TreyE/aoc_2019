defmodule AOC.Day02.VmState do
  defstruct [
    current_index: 0,
    memory_buffer: %{},
    opcodes: %{}
  ]

  def new(buffer) do
    mapped = Enum.with_index(buffer)
    m_buffer = Enum.reduce(mapped, %{}, fn({e, i}, acc) ->
      Map.put(acc, i, e)
    end)
    %__MODULE__{
      memory_buffer: m_buffer,
      opcodes: register_opcodes()
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
    case Map.get(state.opcodes, op_code, :halt) do
      :halt -> {:halt, state}
      oc -> {:cont, execute(state, oc)}
    end
  end

  def execute(state, opcode) do
    state
      |> opcode.function.()
      |> move_index(opcode.width)
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

  defp register_opcodes() do
    opcodes = [
      AOC.Day02.OpCode.new(
        1,
        4,
        &AOC.Day02.OpCode.add/1
      ),
      AOC.Day02.OpCode.new(
        2,
        4,
        &AOC.Day02.OpCode.multi/1
      )
    ]
    Enum.reduce(opcodes, %{}, fn(oc, acc) ->
      Map.put(acc, oc.code, oc)
    end)
  end
end
