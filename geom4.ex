defmodule Geom do
  def area( shape, a, b ) do
    case shape do 
      :rectangle when a > 0 and b > 0 -> a * b
      :triangle  when a > 0 and b > 0 -> 0.5 * a * b
      :ellipse   when a > 0 and b > 0 -> :math.pi() * a * b
      _ -> 0
    end
  end
end
