defmodule Hivebot.Executor do

  def exec(:hello, message, slack, state) do
    reply = "Hello #{slack.users[message.user].name} !"
    {:reply, reply, state}
  end

  def exec({:meme, query}, _message, _slack, state) do
    reply = Hivebot.MemeCenter.random_meme(query).img_url
    {:reply, reply, state}
  end

  def exec(_,_,_,_) do
    :noop
  end

end
