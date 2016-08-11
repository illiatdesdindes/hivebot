defmodule Hivebot.MemeCenter do

  # Exemple Meme data from meme center
  #%{
  #  added_date: 1442596034,
  #  comcount: "43",
  #  featured: 0,
  #  featured_date: 1442603774,
  #  height: 916,
  #  id: "5951439",
  #  score: "894",
  #  seo_title: "banana-philosophy",
  #  title: "Banana Philosophy ",
  #  type: 1,
  #  user_id: "1668681",
  #  username: "spiderdian",
  #  width: 600
  #}

  def random_meme(query) do
    query
    |> search_meme
    |> Enum.random
  end

  def search_meme(query) do
    get("/search/#{URI.encode(query)}/1").body
    |> JSX.decode!
    |> Enum.map(fn meme -> symbolify(meme) end)
    |> Enum.map &construct_img_url/1
  end

  def get(url) do
    HTTPoison.get!("http://www.memecenter.com/" <> url)
  end

  defp symbolify(meme) do
    meme
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
    |> Enum.into %{}
  end

  defp construct_img_url(meme) do
    Map.put meme, :img_url,
    "http://img.memecdn.com/#{meme.seo_title}_c_#{meme.id}.webp"
  end

end
