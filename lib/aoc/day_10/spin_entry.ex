defmodule AOC.Day10.SpinEntry do
  defstruct [angle: 0, entries: []]

  def new(angle, entries) do
    %__MODULE__{
      angle: angle,
      entries: entries
    }
  end

  def zap(%__MODULE__{entries: []}) do
    :empty
  end

  def zap(%__MODULE__{entries: [a|rest]} = rec) do
    updated = %__MODULE__{
      rec |
      entries: rest
    }
    {a, updated}
  end
end
