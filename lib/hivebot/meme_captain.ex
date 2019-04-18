defmodule Hivebot.MemeCaptain do
  def random_meme(query) do
    query
    |> search_meme
    |> Enum.random()
  end

  def search_meme(query) do
    get("/src_images.json?q=#{URI.encode(query)}&page=2").body
    |> JSX.decode!()
    |> Enum.map(fn meme -> symbolify(meme) end)
  end

  def get(url) do
    HTTPoison.get!("http://memecaptain.com/" <> url)
  end

  defp symbolify(meme) do
    meme
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
    |> Enum.into(%{})
  end
end
