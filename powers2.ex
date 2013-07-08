defmodule Powers do
  import Kernel, except: [raise: 2, raise: 3]

  @doc"""
  This is the tail recursive version of raise.
  """
  def raise(_x, 0) do
    1
  end

  def raise(x, n) when n < 0 do
    1.0 / raise(x, -n) 
  end

  def raise(x, n) when n > 0 do
    raise(x, n, 1)
  end

  def raise(_x, 0, accumulator) do
    accumulator
  end

  def raise(x, n, accumulator) do
    raise(x, n - 1, x * accumulator)
  end
  
  # n must be an integer
  def nth_root(x, n) do
    nth_root(x, n, x / 2.0)
  end

  def nth_root(x, n, estimate) do
    IO.puts "Current guess is #{estimate}"
    f       = raise(estimate, n) - x
    f_prime = n * raise(estimate, n - 1)
    next    = estimate - (f * 1.0 / f_prime)
    change  = abs(next - estimate)
    
    # if change < 1.0e-8 do
    #   next
    # else
    #   nth_root(x, n, next)
    # end
    cond do
      change < 1.0e-8 -> next
      true -> nth_root(x, n, next)
    end
  end
end
