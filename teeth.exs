defmodule Teeth do
  def alert(pocket_depths) do
    alert(pocket_depths, 1, []) 
  end

  defp alert([], _, tooth_numbers) do
    Enum.reverse(tooth_numbers)
  end

  defp alert([h|t], current_tooth, tooth_numbers) do
    cond do
      Stats.maximum(h) >= 4 ->
        alert(t, current_tooth+1, [current_tooth|tooth_numbers])
      true -> 
        alert(t, current_tooth+1, tooth_numbers)
    end
  end

  def pocket_depths do
    [[0], [2,2,1,2,2,1], [3,1,2,3,2,3],
    [3,1,3,2,1,2], [3,2,3,2,2,1], [2,3,1,2,1,1],
    [3,1,3,2,3,2], [3,3,2,1,3,1], [4,3,3,2,3,3],
    [3,1,1,3,2,2], [4,3,4,3,2,3], [2,3,1,3,2,2],
    [1,2,1,1,3,2], [1,2,2,3,2,3], [1,3,2,1,3,3], [0],
    [3,2,3,1,1,2], [2,2,1,1,3,2], [2,1,1,1,1,2],
    [3,3,2,1,1,3], [3,1,3,2,3,2], [3,3,1,2,3,3],
    [1,2,2,3,3,3], [2,2,3,2,3,3], [2,2,2,4,3,4],
    [3,4,3,3,3,4], [1,1,2,3,1,2], [2,2,3,2,1,3],
    [3,4,2,4,4,3], [3,3,2,1,2,3], [2,2,2,2,3,3],
    [3,2,3,2,3,2]]
  end
end

defmodule Stats do
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
end
