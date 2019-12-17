defmodule AOC.Day10.SearchPath do
  def distance({x1, y1}, {x2, y2}) do
    x_diff = (x2 - x1)
    y_diff = (y2 - y1)
    ((x_diff *  x_diff) + (y_diff * y_diff))
  end

  def angle({x1, y1}, {x2, y2}) do
    {a, b} = reduce({x2 - x1, y2 - y1})
    :math.atan2(-b, a) + :math.pi
  end

  def normalized_direction({x1, y1}, {x2, y2}) do
    reduce({x1 - x2, y1 - y2})
  end

  defp reduce({a, b}) do
    gcd_val = Integer.gcd(a, b)
    case gcd_val > 1 do
      false -> {a, b}
      _ -> {div(a,gcd_val), div(b,gcd_val)}
    end
  end
end
