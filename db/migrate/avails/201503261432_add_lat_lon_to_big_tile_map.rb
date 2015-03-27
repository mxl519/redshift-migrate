class AddLatLonToBigTileMap < ActiveRecord::Migration
  def change
    add_column :big_tile_map, :normalized_lat, :integer, :encode => :lzo
    add_column :big_tile_map, :normalized_lon, :integer, :encode => :lzo
  end
end
