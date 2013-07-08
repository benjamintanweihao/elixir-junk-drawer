defmodule Geom do

  @doc """
  Calculates the area of a rectangle.
  """
  def area( length // 1, width // 1 ) do
    length * width
  end
end

defmodule Test do
  def sum( a // 3, b, c // 7, d) do
    a + b + c + d
  end
end
