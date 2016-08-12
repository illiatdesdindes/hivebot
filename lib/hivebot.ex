defmodule Hivebot do
  use Application


  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    unless Mix.env == :prod do
      Envy.auto_load
    end

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Hivebot.Worker.start_link(arg1, arg2, arg3)
      # worker(Hivebot.Worker, [arg1, arg2, arg3]),
      worker(Hivebot.Slack, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hivebot.Supervisor]

    # Bad hack to prevent automaticaly connecting to slack evry time we run test
    if Mix.env == :test do
      {:ok, self()}
    else
      Supervisor.start_link(children, opts)
    end
  end
end
