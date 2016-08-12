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

  @cdn_url "http://img.memecdn.com/"

  @image_type %{
    jpeg: 1,
    gif: 2,
    youtube: 3,
    gifmaker: 4,
    png: 5,
    memebuilder: 6,
    animatedgif: 7,
    quickmeme: 9
  }

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
    type = to_i meme.type
    url =
      cond do
        type == @image_type.jpeg          -> url_form_1(meme)
        type == @image_type.gif           -> url_form_1(meme)
        type == @image_type.png           -> url_form_1(meme)
        type == @image_type.memebuilder   -> url_form_1(meme)
        type == @image_type.quickmeme     -> url_form_1(meme)

        type == @image_type.animatedgif   -> url_form_2(meme)
        type == @image_type.gifmaker      -> url_form_2(meme)
      end

    Map.put meme, :img_url, url

  end

  defp url_form_1(meme) do

    l =
      if meme.width > 500 && meme.type != @image_type.gif do
        "c"
      else
        "o"
      end

    @cdn_url <> "#{meme.seo_title}_#{l}_#{meme.id}.jpg"
  end

  defp url_form_2(meme) do
    @cdn_url <> "#{meme.seo_title}_o_#{meme.id}.gif"
  end

  defp to_i(val) when is_bitstring(val), do: String.to_integer val
  defp to_i(val), do: val
end
