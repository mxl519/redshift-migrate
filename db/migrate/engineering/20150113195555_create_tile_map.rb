class CreateTileMap < ActiveRecord::Migration
  def up
    create_table :tile_map, :id => false, :options => 'SORTKEY (tile_id)' do |t|
      t.integer :tile_id, :null => false, :encode => :delta
      t.integer :normalized_lat, :encode => :lzo
      t.integer :normalized_lon, :encode => :lzo
      t.string :state_id, :encode => :text255
      t.string :zip, :encode => :text32k
      t.string :dma, :encode => :text255
      t.string :city_geoid, :encode => :text32k
      t.string :timezone, :encode => :text255
      t.integer :nielsen_dma, :encode => :bytedict
    end
    grant_select :tile_map
  end

  def down
    drop_table :tile_map
  end
end
