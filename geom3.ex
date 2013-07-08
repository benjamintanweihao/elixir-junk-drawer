defmodule Geom do
  def area( { shape, a, b } ) do
    area( shape , a, b )
  end

  defp area( :rectangle, length, width ) when length > 0 and width > 0 do
    length * width
  end

  defp area( :triangle, base, height ) when base > 0 and height > 0 do
    base * height / 2.0
  end

  defp area( :ellipse, major_radii, minor_radii ) when major_radii > 0 and minor_radii > 0 do
    :math.pi() * major_radii * minor_radii 
  end

  defp area( _, _, _ ) do
    0
  end
end
