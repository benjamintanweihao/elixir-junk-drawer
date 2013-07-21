defmodule Sequence.Supervisor do
  use Supervisor.Behaviour

  def start_link(initial_number) do
    # 1. delegates to Erlang's supervisor library
    # 2. initial_number is the parameter passed to the 
    #    supervised process
    # 3. note: the sequence process has not been started ...
    :supervisor.start_link(__MODULE__, initial_number) 
  end

  # instead, the supervisor is started in a separate process ...
  # then, the init function is called.

  # responsible for starting the supervised process
  def init(initial_number) do
    # the worker function creates a specification of a child worker. 
    # takes the name of the module containing the worker, and the
    # parameter to pass in.
    
    child_process = [ worker(Sequence.Server, [initial_number]) ]
    supervise child_process, strategy: :one_for_one
  end
end
