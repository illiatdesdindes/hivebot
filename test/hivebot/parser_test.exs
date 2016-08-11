defmodule Hivebot.ParserTest do

  use ExUnit.Case
  doctest Hivebot.Parser

  alias Hivebot.Parser

  test "parse hello text" do
    assert {:ok, :hello} == Parser.parse %{text: "hello"}
  end

  test "parse meme command" do
    assert {:ok, {:meme, "minion banana"}} == Parser.parse %{text: "/meme minion banana"}
  end

  test "parse a noop text" do
    assert {:ok, :noop} == Parser.parse %{text: "text that dosn't do anything"}
  end

end
