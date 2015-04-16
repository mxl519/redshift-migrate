class CreateTileMap < ActiveRecord::Migration
  def up
    create_table :tile_map, :id => false, :options => 'DISTSTYLE ALL' do |t|
      t.integer :tile_id, :null => false, :encode => :delta
      t.integer :normalized_lat, :encode => :delta32k
      t.integer :normalized_lon, :encode => :delta32k
      t.string :state_id, :limit => 50, :encode => :lzo
      t.string :zip, :limit => 10, :encode => :lzo
      t.string :dma, :limit => 100, :encode => :lzo
      t.string :city_geoid, :limit => 20, :encode => :lzo
      t.string :timezone, :limit => 50, :encode => :lzo
      t.integer :nielsen_dma, :encode => :bytedict
    end
    grant_select :tile_map
  end

  def down
    drop_table :tile_map
  end
end