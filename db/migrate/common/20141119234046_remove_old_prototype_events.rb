class RemoveOldPrototypeEvents < ActiveRecord::Migration
  # Clean up backwards-compatibility from RenameEventsToEventsRaw
  def up
    drop_table prototype_name(:events)
  end

  def down
    execute "CREATE TABLE #{prototype_name(:events)} (LIKE #{prototype_name(:events_raw)});"
  end
end
