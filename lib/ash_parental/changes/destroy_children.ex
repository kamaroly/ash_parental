# lib/changes/destroy_children.ex
defmodule AshParental.Changes.DestroyChildren do
  use Ash.Resource.Change

  @impl true
  def change(changeset, _opts, context) do
    # Before executing this action, first destroy its
    # related subitems.
    Ash.Changeset.before_action(changeset, &delete_children(&1, context))
  end

  @impl true
  def atomic(changeset, opts, context) do
    {:ok, change(changeset, opts, context)}
  end

  defp delete_children(changeset, context) do
    require Ash.Query
    record = changeset.data
    # Delete all the records whose parent ID matches the current
    # record id. We need context so that even when it is being
    # used in multitenant session, it works.
    %{status: :success} =
      changeset.data.__struct__
      |> Ash.Query.filter(parent_id == ^record.id)
      |> Ash.bulk_destroy(:destroy, %{}, Ash.Context.to_opts(context))

    changeset
  end
end
