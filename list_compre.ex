defmodule ListCompre do
  def the_list do
    [
      {"Federico", "M", 22}, 
      {"Kim", "F", 45}, 
      {"Hansa", "F", 30},
      {"Tran", "M", 47}, 
      {"Cathy", "F", 32}, 
      {"Elias", "M", 50}
    ]
  end

  # Names of all the people who are male and over 40 
  def run do
    # Multiple line version
    lc {name, sex, age} inlist the_list, age > 40, sex == "M" do
      name
    end

    # Single line version
    lc {name, sex, age} inlist the_list, age > 40, sex == "M", do: name
  end
end

