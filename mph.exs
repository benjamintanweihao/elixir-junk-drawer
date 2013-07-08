defmodule MphDrop do
  def mph_drop do
    #NOTE: Error handling
    Process.flag(:trap_exit, true)
    drop_pid = spawn_link(Drop, :drop, [])
    convert(drop_pid)
  end

  def convert(drop_pid) do
    receive do
      {planemo, distance} ->
        drop_pid <- { self, planemo, distance}
        convert(drop_pid)
      {:EXIT, pid, reason} ->
        IO.puts "Failure: #{inspect pid} #{inspect reason}"
        new_drop_pid = spawn_link(Drop, :drop, [])
        convert(new_drop_pid)
      {planemo, distance, velocity} ->
        mph_velocity = 2.23693629 * velocity
        IO.write("On #{planemo}, a fall if #{distance} meters ")
        IO.puts "yields a velocity of #{mph_velocity} mph."
        convert(drop_pid)
    end
  end
end

defmodule Drop do
  def drop do
    receive do
      {from, planemo, distance} ->
        from <- {planemo, distance, fall_velocity(planemo, distance)}
      drop
    end
  end

  defp fall_velocity(:earth, distance) when distance >= 0 do
    :math.sqrt(2 * 9.81 * distance)
  end

  defp fall_velocity(:moon, distance) when distance >= 0 do
    :math.sqrt(2 * 1.6 * distance)
  end

  defp fall_velocity(:mars, distance) when distance >= 0 do
    :math.sqrt(2 * 3.71 * distance)
  end
end
