defmodule Powers do
  import Kernel, except: [raise: 2]

  def raise(_x, 0) do
    1
  end

  def raise(x, 1) do
    x
  end

  def raise(x, n) when n > 1 do
    x * raise(x, n-1)
  end

  def raise(x, n) do
    1.0 / raise(x, -n)
  end
end
