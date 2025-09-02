# # lib/transformers/add_delete_destroy_children_change.ex
defmodule AshParental.Transformers.AddDestroyWithChildrenChange do
  use Spark.Dsl.Transformer
  alias AshParental.Info
  alias AshParental.Changes.DestroyChildren
  alias AshParental.Transformers.AddHasManyChildrenRelationship

  @doc """
  Ensures this transformer runs after the AddHasManyChildrenRelationship transformer
  """
  def after?(AddHasManyChildrenRelationship), do: true
  def after?(_), do: false

  @doc """
  If destroy with children is set to true, then add DestroyChildren that will
  run only "on destroy" event. If the setting is not set to true then
  skip, return the dsl_state as it is.
  """
  def transform(dsl_state) do
    if Info.ash_parental_destroy_with_children?(dsl_state) do
      Ash.Resource.Builder.add_change(dsl_state, DestroyChildren, on: :destroy)
    else
      {:ok, dsl_state}
    end
  end
end
