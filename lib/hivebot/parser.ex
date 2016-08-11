defmodule Hivebot.Parser do

  def parse(%{text: "hello"}) do
    {:ok, :hello}
  end

  def parse(%{ text: "/meme" <> query}) do
    {:ok, {:meme, String.trim(query)}}
  end

  def parse(_message) do
    {:ok, :noop}
  end

end
