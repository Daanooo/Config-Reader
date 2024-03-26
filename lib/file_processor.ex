defmodule ConfigReader.FileProcessor do
  def read_file() do
    if !File.exists?(".config"), do: {:error, ".config not found"}

    File.stream!(".config")
    |> Enum.map(&String.split(&1, "="))
    |> Enum.map(fn [key, value] -> {key, String.trim(value)} end)
    |> Enum.into(%{})
  end
end
