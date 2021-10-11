defmodule PoeBuildPricer do
  alias PoeBuildPricer.Item
  @moduledoc """
  PoeBuildPricer keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def create_item(attrs) do
    case Item.changeset(%Item{}, attrs) do
      %{valid?: true} = changeset ->
        item = 
          changeset
          |> Ecto.Changeset.apply_changes()
          |> Map.put(:id, Ecto.UUID.generate())
        {:ok, item}
      changeset ->
        {:error, changeset}
    end
  end

  def item_to_json(item) do
    item
    |> Map.from_struct
    |> Jason.encode
  end
end
