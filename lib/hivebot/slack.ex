defmodule Hivebot.Slack do

  use Slack

  ## API
  ######

  def start_link do
    slack_token = System.get_env("HIVEBOT_SLACK_TOKEN")
    {:ok, pid} = start_link(slack_token, [])
    Process.register(pid, __MODULE__)
    {:ok, pid}
  end

  def get_slack_data do
    send __MODULE__, {self, :get_slack_data}
    receive do
      {:slack, slack} -> slack
    end
  end


  # CALLBACKS
  ###########

  def handle_connect(slack) do
    IO.puts "Connected as #{slack.me.name}"
    IO.puts slack
    :ok
  end

  def handle_message(message = %{type: "message", text: "hello"}, slack, state) do
    reply = "Hurray ! #{slack.users[message.user].name}, hello to you !"
    IO.puts reply
    send_message reply, message.channel, slack

    {:ok, state}
  end

  def handle_message(message, slack, state) do
    IO.puts "\n==== NEW message ===="
    IO.inspect message
    IO.inspect state

    {:ok, state}
  end

  def handle_info({pid, :get_slack_data}, slack, state) do
    send pid, {:slack, slack}
    {:ok, state}
  end

  def handle_info(message, _slack, state) do
    IO.puts "[info]"
    IO.inspect message

    {:ok, state}
  end

  def handle_close(reason, _slack, state) do
    IO.puts "[close]"
    IO.inspect reason
    {:error, state}
  end

end
