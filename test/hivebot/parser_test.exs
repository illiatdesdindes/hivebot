defmodule Hivebot.ParserTest do

  use ExUnit.Case
  doctest Hivebot.Parser

  alias Hivebot.Parser

  test "parse hello text" do
    assert Parser.parse(%{text: "hello"}) == {:ok, :hello}
  end

  test "parse meme command" do
    assert Parser.parse(%{text: "meme minion banana"}) == {:ok, {:meme, "minion banana"}}
    assert Parser.parse(%{text: "memem minion banana"}) == :noop
    assert Parser.parse(%{text: "blameme minion banana"}) == :noop
    assert Parser.parse(%{text: "bla meme minion banana"}) == :noop
  end

  test "parse a noop text" do
    assert Parser.parse(%{text: "text that dosn't do anything"}) == :noop
  end

end
