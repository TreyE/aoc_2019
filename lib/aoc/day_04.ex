defmodule AOC.Day04 do
  def run1 do
    Enum.count(134564..585159, fn(n) ->
      AOC.Day04.ValidationState.valid?(to_string(n))
    end)
  end

  def run2 do
    Enum.count(134564..585159, fn(n) ->
      AOC.Day04.StrictValidationState.valid?(to_string(n))
    end)
  end
end
