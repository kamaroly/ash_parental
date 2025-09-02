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
end
