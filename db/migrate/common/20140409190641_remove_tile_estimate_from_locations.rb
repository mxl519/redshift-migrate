class RemoveTileEstimateFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :tile_estimate
  end
end
