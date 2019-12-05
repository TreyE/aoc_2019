defmodule AOC.Day01 do
  def run do
    input = AOC.Day01.Input.parsed_input()
    total_fuel = AOC.Day01.FuelCounter.calculate_fuel_for_all_modules(input)
    IO.puts(total_fuel)
  end
end
