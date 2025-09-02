# Getting Started With Ash Parental
Ash Parental is an Ash Framework extension that brings STI(Single Table Inheritance) capability to your resource. 

If you want to learn how to build Ash extensions like this you can read more in the Ash Framework for Phoenix Developers serie on medium https://medium.com/p/62b58b426246.

## What is single table inheritance (STI)?

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

```ex
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

## Extension Configurations within Resource

It comes with 2 configurations:

1. `children_relationship_name` to rename children relationship name
2. `destroy_with_children?` to indicate whether or not parents should be destroyed with their children

```ex
ash_parental do
    children_relationship_name :subcategories 
     destroy_with_children? true # default is false
end
```