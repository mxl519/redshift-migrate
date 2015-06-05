class AddBigTileIdToEvents < ActiveRecord::Migration
  def change
    add_column :bids_raw, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :hourly
    add_column :bids, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
    add_column :impressions, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
    add_column :win_notices, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
    add_column :impressions_final, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :monthly
    add_column :clicks, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :monthly
    add_column :conversions, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :monthly
    add_column :tracking, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :monthly
  end
end
