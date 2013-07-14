# Notice that the scheduler is task angostic.
# It is designed to handle a varying number of server processes 
# and an unknown amount of work.
defmodule Scheduler do

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    # What is self here?
    # The result of this map is all the pids
    |> Enum.map(fn(_) -> spawn(module, func,  [self]) end)
    # Note that the since the return values are the pids,
    # and we are using the |> operator, therefore the 
    # first parameter is the list of pids.
    |> schedule_processes(to_calculate, [])
  end
  
  # queue is the work needed to be done.
  defp schedule_processes(processes, queue, results) do
    # What messages does it need to handle?
    # { :ready, self }
    # { :answer, n, fib_calc(n), self }
    receive do
      # when we have stuff in the queue
      { :ready, pid } when length(queue) > 0 ->
        [ next | tail ] = queue
        # pop of the queue ... the assign it to the 
        # next process
        pid <- {:fib, next, self}
        # the recrusively call itself again.
        schedule_processes(processes, tail, results)
    
      # when we have nothing left to process, send the 
      # shutdown message to the pid. 
      { :ready, pid } ->
        pid <- { :shutdown }

        if length(processes) > 1 do
          # Wait ... what does this do?
          # delete the shutdown-ed processes from the list of proceeses.
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end) 
        end

      { :answer, number, result, _pid } ->
        # stack the results, then recursively call itself again
        schedule_processes(processes, queue, [{number, result}|results])
    end
  end
end


defmodule FibSolver do
  # only need one scheduler
  def fib(scheduler) do 

    # This is the first message sent to the scheduler. See the 
    # diagram for this.
    scheduler <- { :ready, self }

    # Notice that in the diagram, the messages are the ones which
    # are sent from the scheduler to the fib server
    receive do
      # receives a message { :fib, n, client } and sends back the 
      # answer in the form of { :answer, n, fib_calc(n), self }
      { :fib, n, client } ->
        client <- { :answer, n, fib_calc(n), self }

        # Notice that this will send another { :ready, self }
        # message to the scheduler.
        fib(scheduler) 
      # receives shutdown, cleanly exits.
      { :shutdown } -> exit(0)
    end 
  end
  
  # Here's where we perform the calculation.
  defp fib_calc(0), do: 1
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)
end

to_process = Enum.map(1..20, fn(_) -> :random.uniform(40) end)

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run, [num_processes, FibSolver, :fib, to_process])

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #    time (s)"
  end
  :io.format "~2B        ~.2f~n", [num_processes, time/1000000.0] 
end

