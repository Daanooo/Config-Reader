defmodule ConfigReader.FileProcessor do
  def read_file() do
    if !File.exists?(".config"), do: File.touch(".config")

    File.stream!(".config")
    |> Enum.map(&String.split(&1, "="))
    |> Enum.map(fn
      [key, value] -> {key, String.trim(value)}
      [key] -> {String.trim(key), ""}
    end)
    |> Enum.into(%{})
  end
end
