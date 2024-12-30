defmodule Renatils.Mixfile do
  use Mix.Project

  @version "0.1.3"

  def project do
    [
      app: :renatils,
      version: @version,
      elixir: "~> 1.17",
      description: description(),
      package: package(),
      deps: deps(),
      compilers: Mix.compilers(),
      test_coverage: [tool: ExCoveralls],
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.detail": :test,
        "coveralls.json": :test,
        "coveralls.post": :test
      ]
    ]
  end

  def application do
    [
      env: []
    ]
  end

  defp description do
    """
    TODO
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Renato Massaro"],
      licenses: ["MIT"],
      links: %{}
    ]
  end

  def deps do
    [
      {:decimal, "~> 2.3", optional: true},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.18.2", only: :test}
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
