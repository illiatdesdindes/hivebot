defmodule Hivebot.Executor do

  def exec(:hello, message, slack, state) do
    reply = "Hello #{slack.users[message.user].name} !"
    {:reply, reply, state}
  end

  def exec({:meme, query}, message, slack, state) do
    case Hivebot.MemeCenter.random_meme(query) do
      :empty -> {:reply, "Sorry #{slack.users[message.user].name} can't find anything", state}
      meme   -> {:reply, meme.img_url, state}
    end
  end

  def exec(_,_,_,_) do
    :noop
  end

end
