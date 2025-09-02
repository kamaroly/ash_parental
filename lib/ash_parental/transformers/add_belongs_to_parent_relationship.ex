# lib/transformers/add_belongs_to_parent_relationship.ex
defmodule AshParental.Transformers.AddBelongsToParentRelationship do
  use Spark.Dsl.Transformer

  @doc """
  Ensure that this transformer runs after the AddParentIdAttribute transformer. This will prevent
  errors where the relationship is added before the parent_id field exists.
  """
  def after?(AshParental.Transformers.AddParentIdAttribute), do: true
  def after?(_), do: false

  def transform(dsl_state) do
    Ash.Resource.Builder.add_new_relationship(
      dsl_state,
      :belongs_to,
      :parent,
      AshParental.get_current_resource_name(dsl_state),
      source_attribute: :parent_id,
      destination_attribute: AshParental.get_primary_key_name(dsl_state)
    )
  end
end
