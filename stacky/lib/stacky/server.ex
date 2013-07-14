# This is a server that implements a Stack.
# So far, only pop is implemented
defmodule Stacky.Server do
  use GenServer.Behaviour
  
  # The server is first intialized with the content of the stack
  def init(stack) when is_list(stack) do
    { :ok, stack }
  end
  
  # simply return an empty list if list is empty
  def handle_call(:pop, _from, []) do
    { :reply, [], [] }
  end
  
  # otherwise, returned the popped element, and set the 
  # next server state to be the tail of the list(stack)
  def handle_call(:pop, _from, stack) do
    [head|tail]  = stack
    { :reply, head,  tail }
  end
  
  # slightly more consise
  # def handle_call(:pop, _from, [head|tail]) do
  #   { :reply, head,  tail }
  # end
end
