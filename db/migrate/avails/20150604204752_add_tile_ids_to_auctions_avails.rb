class AddTileIdsToAuctionsAvails < ActiveRecord::Migration
  def change
    add_column :auctions_avails, :tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
    add_column :auctions_avails, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
  end
end
