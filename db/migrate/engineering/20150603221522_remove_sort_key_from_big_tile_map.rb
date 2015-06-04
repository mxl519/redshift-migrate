class RemoveSortKeyFromBigTileMap < ActiveRecord::Migration
  def up
    rename_table :big_tile_map, :big_tile_map_old

    create_table :big_tile_map, :id => false do |t|
      t.integer :malibu_tile_id, :null => false, :encode => :delta
      t.string  :tile_id, :encode => :lzo, :limit => 30
      t.integer :normalized_lat, :encode => :lzo
      t.integer :normalized_lon, :encode => :lzo
      t.string :state_id, :encode => :text255
      t.string :zip, :encode => :text32k
      t.string :dma, :encode => :text255
      t.string :city_geoid, :encode => :text32k
      t.string :timezone, :encode => :text255
      t.integer :nielsen_dma, :encode => :bytedict
    end
    grant_select :big_tile_map

    execute "INSERT INTO big_tile_map(malibu_tile_id, tile_id, normalized_lat,
      normalized_lon, state_id, zip, dma, city_geoid, timezone, nielsen_dma)
      (SELECT malibu_tile_id, tile_id, normalized_lat, normalized_lon, state_id, zip, dma,
      city_geoid, timezone, nielsen_dma
      FROM big_tile_map_old);"

    drop_table :big_tile_map_old
  end

  def down
    drop_table :big_tile_map

    create_table :big_tile_map, :id => false, :options => 'SORTKEY (malibu_tile_id)' do |t|
      t.integer :malibu_tile_id, :null => false, :encode => :delta
      t.string  :tile_id, :encode => :lzo, :limit => 30
      t.integer :normalized_lat, :encode => :lzo
      t.integer :normalized_lon, :encode => :lzo
      t.string :state_id, :encode => :text255
      t.string :zip, :encode => :text32k
      t.string :dma, :encode => :text255
      t.string :city_geoid, :encode => :text32k
      t.string :timezone, :encode => :text255
      t.integer :nielsen_dma, :encode => :bytedict
    end
    grant_select :big_tile_map
  end
end
