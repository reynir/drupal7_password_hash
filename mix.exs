defmodule Drupal7PasswordHash.MixProject do
  use Mix.Project

  def project do
    [
      app: :drupal7_password_hash,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/reynir/drupal7_password_hash.git",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:comeonin, "~> 5.3"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    "Drupal 7 compatible password hashing for Elixir"
  end

  defp package do
    [
      licenses: ["BSD"],
      links: %{"Github" => "https://github.com/reynir/drupal7_password_hash"},
    ]
  end
end
