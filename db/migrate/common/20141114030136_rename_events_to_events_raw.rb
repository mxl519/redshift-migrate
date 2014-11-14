class RenameEventsToEventsRaw < ActiveRecord::Migration
  def up
    execute "CREATE TABLE #{prototype_name(:events_raw)} (LIKE #{prototype_name(:events)});"
  end

  def down
    drop_table prototype_name(:events_raw)
  end
end
