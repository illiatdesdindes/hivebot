defmodule Hivebot.MemeCenterTest do

  use ExUnit.Case
  doctest Hivebot.MemeCenter

  alias Hivebot.MemeCenter

  test "get a random meme" do
    meme = MemeCenter.random_meme("banana split")
  end

end
