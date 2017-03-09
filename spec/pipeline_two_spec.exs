defmodule PipelineTwoSpec do
  use ESpec

  let :pipeline, do: PipelineTwo.start()

  it "returns 4" do
    result = PipelineTwo.call(pipeline(), %PipelineTwo{})
    expect(result.data).to eq(4)
  end
end
