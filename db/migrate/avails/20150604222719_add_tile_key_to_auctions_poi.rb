class AddTileKeyToAuctionsPoi < ActiveRecord::Migration
  def change
    add_column :auctions_poi, :tile_id, :string, :limit => 30, :encode => :lzo, :partitioned => :monthly
  end
end
