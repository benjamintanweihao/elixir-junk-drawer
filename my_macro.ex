defmodule MyMacro do

  defmacro unless(clause, options) do
    quote do: if(!unquote(clause), unquote(options))
  end

end

require MyMacro

MyMacro.unless var, do: IO.puts "false"
