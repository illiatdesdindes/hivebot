defmodule Hivebot.ExecutorTest do

  use ExUnit.Case
  doctest Hivebot.Executor

  alias Hivebot.Executor

  @slack %{
    users: %{
      1 => %{name: "samy"}
    }
  }

  @state []

  test "exec hello text" do
    assert Executor.exec(:hello, %{user: 1}, @slack, @state) == {:reply, "Hello samy !", @state}
  end

  # TODO
  test "exec meme command" do
    assert true == true
  end

end
