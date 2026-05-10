defmodule FretboardChartCalculator.MixProject do
  use Mix.Project

  def project do
    [
      app: :fretboard_chart_calculator,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {FretboardChartCalculator.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.14"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      # TODO bump on release to {:phoenix_live_view, "~> 1.0.0"},
      {:phoenix_live_view, "~> 1.0.0-rc.1", override: true},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.5"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:bandit, "~> 1.5"},
      # SSL
      {:site_encrypt, "~> 0.7"},
      # The calculator kernel
      {:music_scale, git: "https://github.com/yashrk/music_scale/"},
      # Type checks
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["esbuild.install --if-missing"],
      "assets.build": ["esbuild fretboard_chart_calculator"],
      "assets.deploy": [
        "cmd install -D assets/css/app.css priv/static/assets/app.css",
        "cmd install -D assets/fonts/RobotoSlab-Regular.ttf priv/static/fonts/RobotoSlab-Regular.ttf",
        "cmd install -D assets/fonts/RobotoSlab-Bold.ttf priv/static/fonts/RobotoSlab-Bold.ttf",
        "cmd install -D assets/fonts/CormorantGaramond-SemiBold.otf priv/static/fonts/CormorantGaramond-SemiBold.otf",
        "esbuild fretboard_chart_calculator --minify",
        "phx.digest"
      ]
    ]
  end
end
