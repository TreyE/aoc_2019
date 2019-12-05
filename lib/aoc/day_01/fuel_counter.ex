defmodule AOC.Day01.FuelCounter do
  def calculate_fuel_for_all_modules(module_mass_list) do
    Enum.reduce(module_mass_list, 0, fn(mass, total) ->
      calculate_fuel_required(mass) + total
    end)
  end

  def calculate_fuel_required(mass) do
    div(mass, 3) - 2
  end
end
