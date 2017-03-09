defmodule OnePipelinePerApp do
  use Application

  def start(_type, _opts) do
    pipeline = PipelineOne.start
    Application.put_env(:start_flowex, :pipeline, pipeline)
    {:ok, pipeline.sup_pid}
  end
end
