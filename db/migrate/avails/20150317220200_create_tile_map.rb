class CreateTileMap < ActiveRecord::Migration
  def up
    create_table :tile_map, :id => false, :options => 'SORTKEY (tile_id)' do |t|
      t.integer :tile_id, :null => false, :encode => :delta
      t.integer :normalized_lat, :encode => :lzo
      t.integer :normalized_lon, :encode => :lzo
      t.string :state_id, :encode => :bytedict
      t.string :zip, :encode => :lzo
      t.string :dma, :encode => :bytedict
      t.string :city_geoid, :encode => :lzo
      t.string :timezone, :encode => :bytedict
      t.integer :nielsen_dma, :encode => :bytedict
    end
    grant_select :tile_map
  end

  def down
    drop_table :tile_map
  end
end