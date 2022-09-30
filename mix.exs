defmodule LeakedPasswords.MixProject do
  use Mix.Project

  @source_url "https://github.com/tarzan/leaked_passwords"
  @version "1.1.0"

  def project do
    [
      app: :leaked_passwords,
      version: @version,
      elixir: "~> 1.13.0",
      description: """
      Wrapper around Troy Hunt's endpoints for checking whether a given password
      has been leaked in any of his HaveIBeenPwned datasets.
      This wrapper uses the 'safe' endpoints by first calculating the SHA1 and
      then only POSTing the first 5 characters to the API endpoints.
      """,
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs()
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

  defp package do
    [
      name: :leaked_passwords,
      maintainers: ["Maarten Jacobs - @tarzan"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:httpoison, "~> 1.7"}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end
end
