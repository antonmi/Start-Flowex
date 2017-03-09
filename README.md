# StartFlowex

### Examples how to start [Flowex](https://github.com/antonmi/flowex) pipelines

###In general there are three options:
#### 1. Start pipelines in arbitrary supervised process
```elixir
defmodule PipelineGenServer do
  use GenServer

  def init(_opts) do
    pipeline_one = PipelineOne.start
    pipeline_two = PipelineTwo.start

    {:ok, %{pipeline_one: pipeline_one, pipeline_two: pipeline_two}}
  end
end
```
You can also store pipeline structure in Agent or Application environment

#### 2. Start one pipeline per application. In that case pipeline supervisor will be the main supervisor in the application:
```elixir
defmodule OnePipelinePerApp do
  use Application

  def start(_type, _opts) do
    pipeline = PipelineOne.start
    Application.put_env(:start_flowex, :pipeline, pipeline)
    {:ok, pipeline.sup_pid}
  end
end
```

#### 3. Start several pipelines inside one application using `supervised_start` function. In that case pipeline supervisors will be placed under application supervisor:
```elixir
defmodule TwoPipelinesPerApp do
  use Application

  def start(_type, _opts) do
    {:ok, supervisor_pid} = Supervisor.start_link([], strategy: :one_for_one, name: :multi_flowex_sup)

    pipeline_one = PipelineOne.supervised_start(supervisor_pid)
    pipeline_two = PipelineTwo.supervised_start(supervisor_pid)

    Application.put_env(:start_flowex, :pipeline_one, pipeline_one)
    Application.put_env(:start_flowex, :pipeline_two, pipeline_two)

    {:ok,supervisor_pid}
  end
end
```

You can play around with different cases by choosing application module in `application` function in `mix.exs` file

```elixir
def application do
  [
    mod: {InsideSupervisedGenServer, []}
    # mod: {OnePipelinePerApp, []}
    # mod: {TwoPipelinesPerApp, []}
  ]
end```
