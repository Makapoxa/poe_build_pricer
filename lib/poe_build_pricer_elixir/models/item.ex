defmodule PoeBuildPricer.Item do
  @moduledoc """
    POB Parsed item
  """
  use Ecto.Schema
  import Ecto.Changeset
  
  embedded_schema do
    field :rarity, :string
    field :name, :string
    field :type, :string
    field :properties, {:map, :string}
    field :modifiers, {:array, :string}
    field :icon_url, :string
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:rarity, :name, :type, :properties, :modifiers, :icon_url])
    |> validate_required([:rarity, :name])
  end
end