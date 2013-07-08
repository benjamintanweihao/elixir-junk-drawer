defmodule Stats do
  def minimum([head|tail]) do
    minimum(tail, head)
  end

  def minimum([], min) do
    min
  end

  def minimum([head|tail], min) do
    cond do
      head < min -> minimum(tail, head)
      true -> minimum(tail, min)
    end
  end

  def maximum([head|tail]) do
    maximum(tail, head)
  end

  def maximum([], max) do
    max
  end

  def maximum([head|tail], max) do
    cond do
      head > max -> maximum(tail, head)
      true -> maximum(tail, max)
    end
  end

  def range(list) do
    [ minimum(list), maximum(list) ]
  end
end
