defmodule Dijkstra do
  # using the cond construct
  def gcd(m, n) do
    cond do 
      m == n -> m
      m > n -> gcd(m-n, n)
      m < n -> gcd(m , n-m)
    end
  end
  
  # multiple clause version
  def gcd_2(m, n) when m == n do
    m
  end

  def gcd_2(m, n) when m > n do
    gcd(m-n, n)
  end

  def gcd_2(m, n) do
    gcd(m , n-m)
  end
end
