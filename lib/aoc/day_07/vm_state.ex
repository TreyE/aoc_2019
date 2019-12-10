defmodule AOC.Day07.VmState do
  alias AOC.Day07.OpCode

  defstruct [
    current_index: 0,
    memory_buffer: %{},
    opcodes: %{},
    output_buffer: [],
    output_target: nil,
    vm_id: nil,
    manager: nil
  ]

  def new(buffer, vm_id, output_target, manager) do
    mapped = Enum.with_index(buffer)
    m_buffer = Enum.reduce(mapped, %{}, fn({e, i}, acc) ->
      Map.put(acc, i, e)
    end)
    %__MODULE__{
      memory_buffer: m_buffer,
      opcodes: register_opcodes(),
      output_target: output_target,
      vm_id: vm_id,
      manager: manager
    }
  end

  def wait_init(state) do
    receive do
      {:start, _} ->  run(state)
      {:set_output, op} ->  assign_output(state, op)
    end
  end

  def assign_output(state, op) do
    %{
      state |
      output_target: op
    }
    |> wait_init()
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

  defp next(state) do
    {op_code, flags} = read_opcode_and_flags(state)
    case Map.get(state.opcodes, op_code, :halt) do
      :halt ->
        send(state.manager, {:halt, state.vm_id})
        {:halt, state}
      oc -> {:cont, execute(state, oc, flags)}
    end
  end

  defp execute(state, opcode, flags) do
    state
      |> opcode.function.(flags)
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

  def set_index(state, offset) do
    %__MODULE__{
      state |
      current_index: offset
    }
  end

  def output(state, output_value) do
    Enum.each(state.output_target, fn(ot) ->
      send(ot, {:input, state.vm_id, output_value})
    end)
    %__MODULE__{
      state |
      output_buffer: [output_value|state.output_buffer]
    }
  end

  defp register_opcodes() do
    opcodes = [
      OpCode.new(
        1,
        &OpCode.add/2
      ),
      OpCode.new(
        2,
        &OpCode.multi/2
      ),
      OpCode.new(
        3,
        &OpCode.read/2
      ),
      OpCode.new(
        4,
        &OpCode.print/2
      ),
      OpCode.new(
        5,
        &OpCode.j_true/2
      ),
      OpCode.new(
        6,
        &OpCode.j_false/2
      ),
      OpCode.new(
        7,
        &OpCode.lt/2
      ),
      OpCode.new(
        8,
        &OpCode.eq/2
      )
    ]
    Enum.reduce(opcodes, %{}, fn(oc, acc) ->
      Map.put(acc, oc.code, oc)
    end)
  end

  defp read_opcode_and_flags(state) do
    ip_input = Map.fetch!(state.memory_buffer, state.current_index)
    {rem(ip_input, 100), div(ip_input, 100)}
  end
end
