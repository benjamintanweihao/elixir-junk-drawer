# We are making a supervisor tree!
defmodule Sequence.Supervisor do
  use Supervisor.Behaviour
  
  def start_link(initial_number) do
    # 1. Starts up the Main Supervisor. This will in turn call the 
    #    'init' callback
    result = {:ok, sup} = :supervisor.start_link(__MODULE__, [initial_number])
    # sup is the Main Supervisor

    # 3. this is then called.
    start_workers(sup, initial_number)
    result
  end
  
  def start_workers(sup, initial_number) do
    # 4. Starts the Stash worker (See the diagram. This is the LHS of the tree.
    {:ok, stash} = :supervisor.start_child(sup, worker(Sequence.Stash, [initial_number]))
  
    # 5. Starts the Sub Supervisor (See the diagram. This is the RHS of the tree)
    :supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
  end

  def init(_) do
    # 2. 'supervise' is called. The Main supervisor is now running.
    #    But, since we pass it the empty list, it has no children.
    supervise [], strategy: :one_for_one
  end

end
