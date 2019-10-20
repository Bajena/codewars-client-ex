defmodule CodewarsClientTest do
  use ExUnit.Case
  doctest CodewarsClient

  test "greets the world" do
    assert CodewarsClient.hello() == :world
  end
end
