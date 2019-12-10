defmodule AOC.Day09.OpCode do
  alias AOC.Day09.VmState

  defstruct [
    code: 99,
    function: :halt
  ]

  def new(code, func) do
    %__MODULE__{
      code: code,
      function: func
    }
  end

  def add(state, flags) do
    output_location = read_out_param(state, 2, flags)
    operand_1 = read_pos_param(state, 0, flags)
    operand_2 = read_pos_param(state, 1, flags)
    state
    |> VmState.write(output_location, operand_1 + operand_2)
    |> VmState.move_index(4)
  end

  def multi(state, flags) do
    output_location = read_out_param(state, 2, flags)
    operand_1 = read_pos_param(state, 0, flags)
    operand_2 = read_pos_param(state, 1, flags)
    state
    |> VmState.write(output_location, operand_1 * operand_2)
    |> VmState.move_index(4)
  end

  def read(state, flags) do
    read_value = receive do
      {:input, _, iv} -> iv
    end
    output_location = read_out_param(state, 0, flags)
    state
    |> VmState.write(output_location, read_value)
    |> VmState.move_index(2)
  end

  def print(state, flags) do
    output_value = read_pos_param(state, 0, flags)
    state
    |> VmState.output(output_value)
    |> VmState.move_index(2)
  end

  def j_true(state, flags) do
    operand_1 = read_pos_param(state, 0, flags)
    operand_2 = read_pos_param(state, 1, flags)
    case operand_1 > 0 do
      false -> VmState.move_index(state, 3)
      _ -> VmState.set_index(state, operand_2)
    end
  end

  def j_false(state, flags) do
    operand_1 = read_pos_param(state, 0, flags)
    operand_2 = read_pos_param(state, 1, flags)
    case operand_1 do
      0 -> VmState.set_index(state, operand_2)
      _ -> VmState.move_index(state, 3)
    end
  end

  def lt(state, flags) do
    operand_1 = read_pos_param(state, 0, flags)
    operand_2 = read_pos_param(state, 1, flags)
    output_location = read_out_param(state, 2, flags)
    result_value = case operand_1 < operand_2 do
      false -> 0
      _ -> 1
    end
    state
    |> VmState.write(output_location, result_value)
    |> VmState.move_index(4)
  end

  def eq(state, flags) do
    operand_1 = read_pos_param(state, 0, flags)
    operand_2 = read_pos_param(state, 1, flags)
    output_location = read_out_param(state, 2, flags)
    result_value = case operand_1 == operand_2 do
      false -> 0
      _ -> 1
    end
    state
    |> VmState.write(output_location, result_value)
    |> VmState.move_index(4)
  end

  def adjust_rel_base(state, flags) do
    operand_1 = read_pos_param(state, 0, flags)
    %{
      state |
      relative_base: (state.relative_base + operand_1)
    }
    |> VmState.move_index(2)
  end

  def read_pos_param(state, idx, flags) do
    case mode_for_arg(flags, idx) do
      1 -> Map.get(state.memory_buffer, state.current_index + 1 + idx, 0)
      2 ->
        pos = Map.fetch!(state.memory_buffer, state.current_index + 1 + idx)
        Map.get(state.memory_buffer, state.relative_base + pos, 0)
      _ ->
        arg_location = Map.fetch!(state.memory_buffer, state.current_index + 1 + idx)
        Map.get(state.memory_buffer, arg_location, 0)
    end
  end

  def read_out_param(state, idx, flags) do
    case mode_for_arg(flags, idx) do
      2 ->
        pos = Map.get(state.memory_buffer, state.current_index + 1 + idx, 0)
        state.relative_base + pos
      _ -> Map.get(state.memory_buffer, state.current_index + 1 + idx, 0)
    end
  end

  def mode_for_arg(flags, arg_pos) do
    arg_div = trunc(:math.pow(10, arg_pos))
    flags
    |> div(arg_div)
    |> rem(10)
  end
end
