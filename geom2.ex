defmodule Geom do
  @moduledoc """
  Functions for calculating areas of geometric shapes.
  """

  @doc """
  Calculates the area of a shape, given the shape and two of the 
  dimensions. Returns the product of its arguments for a rectangle,
  one half of the product of the arguments for a triangle, and :math.pi
  times the product of the arguments for an ellipse.
  """

  @spec area(atom(), number(), number()) :: number()

  def area( :rectangle, length, width ) when length > 0 and width > 0 do
    length * width
  end

  def area( :triangle, base, height ) when base > 0 and height > 0 do
    base * height / 2.0
  end

  def area( :ellipse, major_radii, minor_radii ) when major_radii > 0 and minor_radii > 0 do
    :math.pi() * major_radii * minor_radii 
  end

  def area( _, _, _ ) do
    0
  end
end
