class AddCongressionalDistrictToBigTileMap < ActiveRecord::Migration
  def change
    add_column :big_tile_map, :congressional_district_id, :string, :limit => 25, :encode => :lzo
  end
end
