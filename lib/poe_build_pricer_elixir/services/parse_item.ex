defmodule PoeBuildPricer.ParseItem do
  @moduledoc """
    Service to parse item from pob text
  """
  def call(item_string) do
    {:ok, lines} = raw_parse(item_string)
    
    [rarity_line | lines] = lines
    true = property?(rarity_line)

    {_, rarity} = parse_property(rarity_line)
    rarity = String.capitalize(rarity)

    [name | lines] = lines
     
    {type, lines} = if property?(List.first(lines)) do
      {nil, lines}
    else
      List.pop_at(lines, 0)
    end

    modifiers = Enum.reject(lines, &property?/1)

    properties = lines
    |> Enum.filter(&property?/1)
    |> Enum.map(&parse_property/1)
    |> Map.new

    icon_url = icon_url(rarity, name, type)

    PoeBuildPricer.create_item(%{rarity: rarity, name: name, type: type, properties: properties, modifiers: modifiers, icon_url: icon_url})
  end

  defp raw_parse(item_string) do
    lines = item_string
    |> String.split("\n")
    |> Enum.map(fn str -> String.replace(str, ~r/\{(.*?)\}/, "") end)
    |> Enum.map(fn str -> String.trim(str) end)
    |> Enum.filter(fn str -> str != "" end)
    
    if length(lines) > 2 do
      {:ok, lines}
    else
      {:error, "Too few lines"}
    end
  end

  defp parse_property(property) do
    [key, value] = property
    |> String.split(":")
    |> Enum.map(fn str -> String.trim(str) end)

    {key, value}
  end

  defp property?(line) do
    String.match?(line, ~r/.*:.*/)
  end

  defp icon_url(rarity, name, type) do
    case rarity do
      "Rare" -> rare_icon_url(type)
      _ -> unique_icon_url(name)
    end
  end

  defp rare_icon_url(type) do
    {:ok, raw_file} = File.read(Application.app_dir(:poe_build_pricer_elixir, "priv/data/base-types.json"))
    {:ok, rares} = Jason.decode(raw_file)
    Enum.find_value(rares, fn list -> List.first(list) == type && List.last(list)["icon"] end)
  end

  defp unique_icon_url(name_to_find) do
    {:ok, raw_file} = File.read(Application.app_dir(:poe_build_pricer_elixir, "priv/data/uniques.json"))
    {:ok, uniques} = Jason.decode(raw_file)
    Enum.find_value(uniques, fn map -> map["name"] == name_to_find && map["icon"] end)
  end
end