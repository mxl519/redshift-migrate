class AddTileIdsToAuctionsSampled < ActiveRecord::Migration
  def change
    add_column :auctions_sampled, :tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
    add_column :auctions_sampled, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
  end
end
