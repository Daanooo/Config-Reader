defmodule ConfigReader.StateTest do
  use ExUnit.Case, async: true

  setup do
    state = start_supervised!(ConfigReader.State)
    %{state: state}
  end

  test "fetches value by key", %{state: state} do
    assert ConfigReader.State.get(state, "test") == "ok"
  end

  test "returns not found when key does not exist", %{state: state} do
    assert ConfigReader.State.get(state, "x") == "Key x not found"
  end
end
