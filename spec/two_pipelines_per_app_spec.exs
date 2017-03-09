defmodule TwoPipelinesPerAppSpec do
  use ESpec

  let :pipeline_one, do: Application.get_env(:start_flowex, :pipeline_one)
  let :pipeline_two, do: Application.get_env(:start_flowex, :pipeline_two)

  it "says hello" do
    result = PipelineOne.call(pipeline_one(), %PipelineOne{})
    expect(result.phrase).to eq("Emm, hello!")
  end

  it "returns 4" do
    result = PipelineTwo.call(pipeline_two(), %PipelineTwo{})
    expect(result.data).to eq(4)
  end
end
