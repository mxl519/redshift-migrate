class DropOldTileMapTables < ActiveRecord::Migration
  def up
    drop_table :tile_map_old
    drop_table :big_tile_map_old
  end

  def down
    create_table :tile_map_old, :id => false, :options => 'SORTKEY (tile_id)' do |t|
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

    create_table :big_tile_map_old, :id => false, :options => 'SORTKEY (tile_id)' do |t|
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
  end
end
