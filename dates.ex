defmodule Dates do
  import Enum

  # Somewhat redundant because String.to_integer returns in a weird format.
  # Nevertheless, a nice exercise.
  def date_parts(date_str) do
    String.split(date_str, %r{-}) |> map(String.to_integer(&1)) |> map(fn({k, _}) -> k end)
  end

  def date_parts_2(date_str) do
    String.split(date_str, %r{-}) |> map(binary_to_integer(&1))
  end

  def julian(date_str) do
    [year, month, day] = date_parts(date_str)
    day + month_total(month, days_per_month(year), 0)
  end

  defp month_total(1, _days_per_month, acc) do
    acc
  end

  defp month_total(month, days_per_month, acc) do
    month_total(month-1, days_per_month, Enum.at(days_per_month, month-1) + acc)
  end

  defp days_per_month(year) do
    [31, days_in_feb(year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  end

  defp is_leap_year(year) do
    (rem(year,4) == 0 and rem(year,100) != 0) or (rem(year, 400) == 0)
  end

  defp days_in_feb(year) do
    cond do
      is_leap_year(year) -> 29
      true -> 28
    end
  end
end
