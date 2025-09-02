# lib/transformers/add_has_many_children_relationship.ex
defmodule AshParental.Transformers.AddHasManyChildrenRelationship do
  use Spark.Dsl.Transformer

  def after?(AshParental.Transformers.AddParentIdAttribute), do: true
  def after?(_), do: false

  def transform(dsl_state) do
    Ash.Resource.Builder.add_new_relationship(
      dsl_state,
      :has_many,
      # <-- Use the configured children relationship name
      AshParental.get_children_relationship_name(dsl_state),
      AshParental.get_current_resource_name(dsl_state),
      source_attribute: AshParental.get_primary_key_name(dsl_state),
      destination_attribute: :parent_id
    )
  end
end
