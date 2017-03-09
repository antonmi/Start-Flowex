defmodule OnePipelinePerAppSpec do
  use ESpec

  let :pipeline, do: Application.get_env(:start_flowex, :pipeline)

  it "says hello" do
    result = PipelineOne.call(pipeline(), %PipelineOne{})
    expect(result.phrase).to eq("Emm, hello!")
  end

  it "returns 4" do
    result = PipelineTwo.call(pipeline(), %PipelineTwo{})
    expect(result.data).to eq(4)
  end
end
