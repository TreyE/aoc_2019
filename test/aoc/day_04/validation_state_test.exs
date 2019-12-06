defmodule AOC.Day04.ValidationStateTest do
  use ExUnit.Case

  test "111111" do
    true = AOC.Day04.ValidationState.valid?("111111")
  end

  test "223450" do
    false = AOC.Day04.ValidationState.valid?("223450")
  end

  test "123789" do
    false = AOC.Day04.ValidationState.valid?("123789")
  end
end
