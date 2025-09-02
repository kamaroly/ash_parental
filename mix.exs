defmodule AshParental.MixProject do
  use Mix.Project

  def project do
    [
      app: :ash_parental,
      version: "0.1.1",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: &docs/0,
      package: package(),
      description: description()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ash, "~> 3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        {"README.md", title: "Home"}
      ]
    ]
  end

  defp description do
    "Ash Parental is an Ash Framework extension that brings STI(Single Table Inheritance) capability to your resource"
  end

  defp package do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "ash_parental",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kamaroly/ash_parental"}
    ]
  end
end
