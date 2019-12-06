defmodule AOC.Day04.StrictValidationStateTest do
  use ExUnit.Case

  test "112233" do
    true = AOC.Day04.StrictValidationState.valid?("112233")
  end

  test "123444" do
    false = AOC.Day04.StrictValidationState.valid?("123444")
  end

  test "111122" do
    true = AOC.Day04.StrictValidationState.valid?("111122")
  end
end
