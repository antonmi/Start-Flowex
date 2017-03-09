defmodule PipelineTwo do
  use Flowex.Pipeline

  defstruct data: nil
  pipe :set
  pipe :add

  def set(struct, _opts), do: %{struct | data: 2}
  def add(struct, _opts), do: %{struct | data: struct.data + 2}
end
