defmodule Sum do
  defstruct value: 0

  def value(%Sum{value: value}), do: value

  def add(%Sum{value: value} = sum, x) do
    %Sum{sum | value: value + x}
  end

  defimpl Collectable do
    def into(original) do
      {
        original,
        fn
          sum, {:cont, x} -> Sum.add(sum, x)
          sum, :done -> sum
          _, :halt -> :ok
        end
      }
    end
  end
end
