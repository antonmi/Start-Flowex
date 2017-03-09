defmodule StartFlowex.Mixfile do
  use Mix.Project

  def project do
    [app: :start_flowex,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [espec: :test],
     deps: deps()]
  end

  def application do
    [
      mod: {InsideSupervisedGenServer, []}
      # mod: {OnePipelinePerApp, []}
      # mod: {TwoPipelinesPerApp, []}
    ]
  end

  defp deps do
    [
      {:flowex, path: "/Users/antonmi/elixir/flowex"},
      {:espec, "1.3.0", only: :test}
    ]
  end
end
