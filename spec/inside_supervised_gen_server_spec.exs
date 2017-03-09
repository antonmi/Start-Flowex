defmodule InsideSupervisedGenServerSpec do
  use ESpec

  it "says hello" do
    result = PipelineGenServer.call_pipeline_one(%PipelineOne{})
    expect(result.phrase).to eq("Emm, hello!")
  end

  it "returns 4" do
    result = PipelineGenServer.call_pipeline_two(%PipelineTwo{})
    expect(result.data).to eq(4)
  end
end
