defmodule ConfigReaderTest do
  use ExUnit.Case

  doctest ConfigReader

  test "greets the world" do
    assert ConfigReader.hello() == :world
  end
end
