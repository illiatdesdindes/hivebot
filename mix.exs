defmodule Hivebot.Mixfile do
  use Mix.Project

  def project do
    [app: :hivebot,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :slack, :httpoison],
     mod: {Hivebot, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:slack, "~> 0.6.0"},
      {:envy, "~> 1.0.0"},
      {:httpoison, "~> 0.8"},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:mr_t, "~> 0.5.0", only: [:test, :dev]},
    ]
  end
end
