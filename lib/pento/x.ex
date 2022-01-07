defmodule Number do
  def new(string), do: Integer.parse(string) |> elem(0)
  def add(x, y), do: x + y
  def to_string(number), do: Integer.to_string(number)
end
