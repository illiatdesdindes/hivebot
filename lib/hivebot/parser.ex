defmodule Hivebot.Parser do

  def parse(message = %{text: text}) do
    cond do
      text =~ ~r/hello/ ->
        hello(message)
      capture = Regex.named_captures(~r/meme +(?<query>\w.*)/, text) ->
        meme(message, capture)
      true -> :noop
    end
  end

  defp hello(%{text: "hello"}) do
    {:ok, :hello}
  end

  defp meme(message, %{"query" => query}) do
    {:ok, {:meme, String.trim(query)}}
  end

end
