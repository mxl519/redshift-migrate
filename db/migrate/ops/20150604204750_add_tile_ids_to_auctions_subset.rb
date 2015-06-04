class AddTileIdsToAuctionsSubset < ActiveRecord::Migration
  def change
    add_column :auctions_subset, :tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
    add_column :auctions_subset, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
  end
end
