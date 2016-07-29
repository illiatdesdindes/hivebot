defmodule Hivebot.Slack do

  use Slack

  def handle_connect(slack) do
    IO.puts "Connected as #{slack.me.name}"
    IO.puts slack
    :ok
  end

  def handle_message(message, slack, state) do
    IO.inspect message
    {:ok, state}
  end

  def handle_info(message, slack) do
    IO.puts "[info]"
    IO.puts message
    IO.puts slack

    :ok
  end

  def handle_close(reason, slack) do
    IO.puts "[close]"
    IO.puts reason
    IO.puts slack
    :ok
  end

end
