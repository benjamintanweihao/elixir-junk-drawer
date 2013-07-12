defmodule Cards do
  
  def make_deck do
    rank = ["A",2,3,4,5,6,7,8,9,10,"J","Q","K"]
    suit = ["Clubs", "Diamonds", "Spades", "Hearts"]
    lc r inlist rank, s inlist suit, do: {r, s}
  end

end
