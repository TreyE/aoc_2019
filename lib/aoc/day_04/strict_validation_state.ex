defmodule AOC.Day04.StrictValidationState do
  defstruct [
    remaining_numbers: <<>>,
    last_number: 0,
    adjacency_blocks: [],
    current_adjacency_block: []
  ]

  def valid?(string) do
    %__MODULE__{
      remaining_numbers: string
    }
    |> validate()
  end

  def validate(%__MODULE__{
    remaining_numbers: <<>>,
    adjacency_blocks: adj,
    current_adjacency_block: c_block
    }) do
    Enum.any?(adj, fn(ele) ->
      Enum.count(ele) == 2
    end) || (Enum.count(c_block) == 2)
  end

  def validate(%__MODULE__{
    remaining_numbers: <<a::utf8,_::binary>>,
    last_number: b
    }) when a < b do
    false
  end

  def validate(%__MODULE__{
    remaining_numbers: <<a::utf8,rest::binary>>,
    last_number: _,
    current_adjacency_block: []
    } = state) do
    %{
      state |
      remaining_numbers: rest,
      last_number: a,
      current_adjacency_block: [a]
    }
    |> validate()
  end

  def validate(%__MODULE__{
    remaining_numbers: <<a::utf8,rest::binary>>,
    last_number: _,
    current_adjacency_block: [a|a_rest]
    } = state) do
    %{
      state |
      remaining_numbers: rest,
      last_number: a,
      current_adjacency_block: [a,a] ++ a_rest
    }
    |> validate()
  end

  def validate(%__MODULE__{
    remaining_numbers: <<a::utf8,rest::binary>>,
    last_number: _,
    current_adjacency_block: other,
    adjacency_blocks: adj
    } = state) do
    %{
      state |
      remaining_numbers: rest,
      last_number: a,
      current_adjacency_block: [a],
      adjacency_blocks: [other|adj]
    }
    |> validate()
  end
end
