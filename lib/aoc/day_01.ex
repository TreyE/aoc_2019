defmodule AOC.Day01 do
  def run1 do
    input = AOC.Day01.Input.parsed_input()
    total_fuel = AOC.Day01.FuelCounter.calculate_fuel_for_all_modules(input)
    IO.puts(total_fuel)
  end

  def run2 do
    input = AOC.Day01.Input.parsed_input()
    total_fuel = AOC.Day01.FuelCounter.calculate_fuel_with_fuel_for_modules(input)
    IO.inspect(total_fuel)
  end
end
