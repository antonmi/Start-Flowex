defmodule InsideSupervisedGenServer do
  use Application

  def start(_type, _opts) do
    import Supervisor.Spec
    children = [
      worker(PipelineGenServer, [], restart: :temporary)
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule PipelineGenServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_opts) do
    pipeline_one = PipelineOne.start
    pipeline_two = PipelineTwo.start

    {:ok, %{pipeline_one: pipeline_one, pipeline_two: pipeline_two}}
  end

  def call_pipeline_one(struct) do
    GenServer.call(__MODULE__, {:call_pipeline_one, struct})
  end

  def call_pipeline_two(struct) do
    GenServer.call(__MODULE__, {:call_pipeline_two, struct})
  end

  def handle_call({:call_pipeline_one, struct}, _from, state) do
    pipeline = state.pipeline_one
    result = pipeline.module.call(pipeline, struct)

    {:reply, result, state}
  end

  def handle_call({:call_pipeline_two, struct}, _from, state) do
    pipeline = state.pipeline_two
    result = pipeline.module.call(pipeline, struct)

    {:reply, result, state}
  end
end
