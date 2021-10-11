defmodule PoeBuildPricer.ParseItemSpec do
  use ESpec

  subject :call, do: PoeBuildPricer.ParseItem.call(raw_data())

  let_ok :raw_data, do: File.read(Application.app_dir(:poe_build_pricer_elixir, "priv/fixtures/jewel"))

  it "parses item correctly" do
    expect call() |> to(match_pattern {:ok, _})

    {:ok, item} = call()

    expect item |> to(have name: "Oblivion Curio")
    expect item |> to(have type: "Crimson Jewel")
    expect item |> to(have rarity: "Rare")
    expect item |> to(have icon_url: "https://web.poecdn.com/image/Art/2DItems/Jewels/basicstr.png")
    expect item |> to(have properties: %{
        "Unique ID" => "2cbde8d73d0f94d106fcac0a9e7fbb2e35851fbcaa4813071b9b43d802672231",
        "Item Level" => "79",
        "Implicits" => "0",
      }
    )
    expect item |> to(have modifiers: [
      "12% increased Melee Damage",
      "+17% to Critical Strike Multiplier with Two Handed Melee Weapons",
      "7% increased maximum Life",
      "+10% to Cold and Lightning Resistances",
    ])
  end
end