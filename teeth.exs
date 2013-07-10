defmodule NonFP do
  # tlist: tooth list
  # good_prob: good tooth probability
  def generate_pockets(tlist, good_prob) do
    generate_pockets(tlist, good_prob, [])
  end

  # base case
  def generate_pockets([], _good_prob, teeth_list), do: Enum.reverse(teeth_list)

  def generate_pockets([?T, tail], good_prob, teeth_list) do
    generate_pockets(tail, good_prob, [ generate_good_teeth(good_prob) | teeth_list ])
  end

  # No Tooth
  def generate_pockets([?F, tail], good_prob, teeth_list) do
    generate_pockets(tail, good_prob, [ [0] | teeth_list ])
  end


  # helper for generating good teeth
  def generate_good_teeth(good_prob) do
    generate_good_teeth(good_prob, 6, [])
  end

  def generate_good_teeth(_good_prob, 0, teeth_list), do: Enum.reverse(teeth_list)

  def generate_good_teeth(good_prob, counter, teeth_list) do
    teeth = generate_tooth(good_prob) 
    generate_good_teeth(good_prob, counter-1, [teeth|teeth_list])
  end

  def generate_tooth(good_prob) do
    r = :random.uniform
    base_depth = cond do 
      r < good_prob -> 2
      true -> 3
    end
    base_depth + :random.uniform(3)-2
  end

  def run do
    tlist = 'FTTTTTTTTTTTTTTFTTTTTTTTTTTTTTTT'
    :random.seed(:erlang.now)
    generate_pockets(tlist, 0.75)
  end
end

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
