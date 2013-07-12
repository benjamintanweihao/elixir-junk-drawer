defmodule Calculus do
 
  # f takes in a function.
  def derivative(f, x) do
    delta = 1.0e-10

    (f.(x + delta) - f.(x)) / delta

    # This does not work:
    # => (f(x + delta) - f(x)) / delta
    # The function f/1 is not defined.
    # The solution is to 'call' the function with the dot.
  end

end
