class AddTileIdsToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
    add_column :auctions, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :weekly
  end
end
