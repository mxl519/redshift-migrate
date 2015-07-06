class AddCongressionalDistrictToTileMap < ActiveRecord::Migration
  def change
    add_column :tile_map, :congressional_district_id, :string, :limit => 25, :encode => :lzo
  end
end
