# lib/ash_parental.ex
defmodule AshParental do
  @transformers [
    AshParental.Transformers.AddParentIdAttribute,
    AshParental.Transformers.AddBelongsToParentRelationship,
    AshParental.Transformers.AddHasManyChildrenRelationship,
    AshParental.Transformers.AddChildrenCountAggregate,
    AshParental.Transformers.AddDestroyWithChildrenChange
  ]

  @section %Spark.Dsl.Section{
    name: :ash_parental,
    describe: "Configurations for the AshParental extension",
    examples: [
      """
      ash_parental do
        children_relationship_name :sub_items
        destroy_with_children? true
      end
      """
    ],
    schema: [
      children_relationship_name: [
        type: :atom,
        doc: "The name of the children relationship to be added",
        default: :children
      ],
      destroy_with_children?: [
        type: :boolean,
        doc: "If true, deleting a parent will also delete its children",
        default: false
      ]
    ]
  }

  use Spark.Dsl.Extension, transformers: @transformers, sections: [@section]

  @spec get_children_relationship_name(atom() | map()) :: atom()
  def get_children_relationship_name(dsl_state) do
    dsl_state
    |> AshParental.Info.ash_parental_children_relationship_name!()
  end

  @spec get_current_resource_name(map()) :: atom()
  def get_current_resource_name(dsl_state) do
    Spark.Dsl.Transformer.get_persisted(dsl_state, :module)
  end

  @spec get_primary_key_name(map()) :: atom()
  def get_primary_key_name(dsl_state) do
    dsl_state
    |> Ash.Resource.Info.primary_key()
    |> Enum.map(&Ash.Resource.Info.attribute(dsl_state, &1))
    |> List.first()
    |> Map.get(:name)
  end

  @spec get_primary_key_type(map()) :: atom()
  def get_primary_key_type(dsl_state) do
    dsl_state
    |> Ash.Resource.Info.primary_key()
    |> Enum.map(&Ash.Resource.Info.attribute(dsl_state, &1))
    |> List.first()
    |> Map.get(:type)
  end
end
