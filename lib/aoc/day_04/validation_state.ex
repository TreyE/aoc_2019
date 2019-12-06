defmodule AOC.Day04.ValidationState do
  defstruct [
    remaining_numbers: <<>>,
    last_number: 0,
    found_adjacent_double: false
  ]

  def valid?(string) do
    %__MODULE__{
      remaining_numbers: string
    }
    |> validate()
  end

  def validate(%__MODULE__{
    remaining_numbers: <<>>,
    found_adjacent_double: a
    }) do
    a
  end

  def validate(%__MODULE__{
    remaining_numbers: <<a::utf8,_::binary>>,
    last_number: b
    }) when a < b do
    false
  end

  def validate(%__MODULE__{
    remaining_numbers: <<a::utf8,rest::binary>>,
    last_number: a
    } = state) do
    %__MODULE__{
      state |
      remaining_numbers: rest,
      found_adjacent_double: true
    }
    |> validate()
  end

  def validate(%__MODULE__{
    remaining_numbers: <<a::utf8,rest::binary>>,
    last_number: _
    } = state) do
    %__MODULE__{
      state |
      remaining_numbers: rest,
      last_number: a
    }
    |> validate()
  end
end
