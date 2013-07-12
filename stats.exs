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

  # foldl(list, acc, function)
  def mean(list) do
    List.foldl(list, 0, fn (x, acc) -> x + acc end) / Enum.count(list)
  end

  # My noob version.
  def stdv(list) do
    sum = List.foldl(list, 0, fn (x, acc) -> x + acc end)
    sum_of_squares = List.foldl(list, 0, fn (x, acc) -> (x * x) + acc end)

    n = Enum.count(list)
    :math.sqrt ((n * sum_of_squares - sum * sum) / (n * (n -1)))
  end

  # Holy shit ... this is awesome. Process 2 lists at once!
  def stdv(list) do
    n = Enum.count(list)
    {sum, sum_of_squares} = List.foldl(list, {0,0}, fn(x, {acc, acc_squares}) -> 
      {x + acc, x*x + acc_squares} end)
    :math.sqrt ((n * sum_of_squares - sum * sum) / (n * (n -1)))
  end

end
