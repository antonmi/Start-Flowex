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
