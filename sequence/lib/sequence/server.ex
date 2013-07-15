defmodule Sequence.Server do
  # This gives our server the GenServer behavior.
  # Using this lets us hook into all the callback behavior.
  use GenServer.Behaviour
  
  # init is invoked by GenServer.
  def init(current_number) when is_number(current_number) do
    { :ok, current_number }
  end

  # first parameter : information passed to the call by the client
  # second          : pid of the client. (ignored for now)
  # third           : the server state

  # A server can handle multiple actions by implemeting different
  # handle_calls with different first parameters.
  def handle_call(:next_number, _from, current_number) do
    # this tuple is returned to OTP.
    # :reply tells OTP to reply to the client, passing the second
    # value back to the client.
    # the third value is the new state of the server.

    # Since this is a callback, this is returned on success
    { :reply, current_number, current_number + 1 }
  end

  # Here's another variation.
  def handle_call({:set_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number }
  end
  
  # We can return a tuple for the reply
  # def handle_call({:factors, number}, _, _) do
  #   { :reply, { :factors_of, number, factors(number)}, [] }
  # end 

  # use handle_cast when you are not waiting for a response. 
  # i.e a command rather than a query
  def handle_cast({:increment_number, delta}, current_number) do
    # this function returns the new state
    # :noreply is the reply on success
    { :noreply, current_number + delta }
  end

  # customize the look of the status message
  def format_status(_reason, [ _pdict, state ]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end

# How to start
# iex -S mix
# {:ok,pid} = :gen_server.start

###################################################################
# start_link asks gen_server to start a new process and link to us.
# so we known when shit happens.

# Start the entire module as a server, giving it the intial state.
###################################################################

# :gen_server.start_link(Sequence.Server, 100, [])


# :gen_server.call(pid, :next_number)
