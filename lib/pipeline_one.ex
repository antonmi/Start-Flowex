defmodule PipelineOne do
  use Flowex.Pipeline

  defstruct phrase: nil
  pipe :say
  pipe :hello

  def say(struct, _opts), do: %{struct | phrase: "Emm,"}
  def hello(struct, _opts), do: %{struct | phrase: "#{struct.phrase} hello!"}
end
