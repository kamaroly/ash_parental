# Getting Started With Ash Parental
Ash Parental is an Ash Framework extension that brings STI(Single Table Inheritance) capability to your resource. 

If you want to learn how to build Ash extensions like this you can read more in the Ash Framework for Phoenix Developers serie on medium https://medium.com/p/62b58b426246.

## What is a single table inheritance (STI)?

It's a fancy name for a simple concept: Extending a resource (usually to add specific behavior), but referencing the same table.

## Installation

The package can be installed by adding `ash_parental` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ash_parental, "~> 0.1.0"}
  ]
end
```

Then add it to your resource like below

```elixir
defmodule MyApp.Comment do
    use Ash.Resource, extensions: [AshParental]
    ....
end
```

## What AshParental Does

This extension adds:

1. `parent_id` attributes to your resource
2. belongs to `parent` relationship
3. has many `children` relationship
4. `children_count` aggregates

## Configurations

It comes with 2 configurations:

1. `children_relationship_name` to rename children relationship name
2. `destroy_with_children?` to indicate whether or not parents should be destroyed with their children

```elixir
  defmodule MyApp.Comment do
    use Ash.Resource,
      domain: MyApp.Domain,
      data_layer: Ash.DataLayer.Ets,
      extensions: [AshParental]

    ets do
      table :comments
    end

    ash_parental do
      children_relationship_name :replies # Default: children 
      destroy_with_children? true # Default: false
    end

    actions do
      defaults [:create, :read, :update, :destroy] 
    end

    attributes do
      uuid_primary_key :id
      attribute :content, :string, allow_nil?: false
      timestamps()
    end
  end
```
