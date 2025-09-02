# lib/transformers/add_parent_id_attribute.ex
defmodule AshParental.Transformers.AddParentIdAttribute do
  use Spark.Dsl.Transformer

  def transform(dsl_state) do
    Ash.Resource.Builder.add_new_attribute(
      dsl_state,
      :parent_id,
      AshParental.get_primary_key_type(dsl_state),
      allow_nil?: false
    )
  end
end
