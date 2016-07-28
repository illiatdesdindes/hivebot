defmodule Hivebot.Slack do

  use Slack

  def handle_connect(slack) do
    IO.puts "Connected as #{slack.me.name}"
    IO.puts slack
  end

  def handle_message(message, slack, state) do
    IO.inspect message
    {:ok, state}
  end

end
