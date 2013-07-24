defmodule Ackermann do
  def ackermann(0, n) do
    n+1
  end

  def ackermann(m, 0) when m > 0 do
    ackermann(m-1, 1)
  end

  def ackermann(m, n) when m > 0 and n > 0 do
    ackermann(m-1, ackermann(m,n-1))
  end
end
