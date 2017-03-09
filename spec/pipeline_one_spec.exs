defmodule PipelineOneSpec do
  use ESpec

  let :pipeline, do: PipelineOne.start()

  it "says hello" do
    result = PipelineOne.call(pipeline(), %PipelineOne{})
    expect(result.phrase).to eq("Emm, hello!")
  end
end
