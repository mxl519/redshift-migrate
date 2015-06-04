class AddTileIdToEventsRaw < ActiveRecord::Migration
  def change
    add_column :events_raw, :tile_id, :string, :partitioned => :hourly, :limit => 30
  end
end
