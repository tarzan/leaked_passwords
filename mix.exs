defmodule LeakedPasswords.MixProject do
  use Mix.Project

  def project do
    [
      app: :leaked_passwords,
      version: "0.1.0",
      elixir: "~> 1.8.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/mocks"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:jason, "~> 1.2"},
      {:httpoison, "~> 1.7"}
    ]
  end
end
