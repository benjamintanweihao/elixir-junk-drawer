defmodule College do
  def make_room_list(file) do
    {:ok, device} = File.open("courses.csv", [:read, :utf8])
    make_room_list(device, HashDict.new)
  end

  def make_room_list(device, hash_dict) do
    line = IO.readline(device)
    process_line(line, device, hash_dict)
  end

  def process_line(:eof, device, hash_dict) do 
    File.close(device)
    hash_dict
  end

  def process_line(line, device, hash_dict) do
    [_, course_name, room] = String.split(String.strip(line), ",")

    cond do 
      HashDict.has_key?(hash_dict, room) ->
        new_hash_dict = Dict.put(hash_dict, room, [course_name | HashDict.get(hash_dict, room)])
      true -> 
        new_hash_dict = Dict.put(hash_dict, room, [course_name])
    end

    next_line = IO.readline(device)
    process_line(next_line, device, new_hash_dict)
  end
end
