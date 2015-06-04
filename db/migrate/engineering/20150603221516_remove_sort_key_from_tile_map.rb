class RemoveSortKeyFromTileMap < ActiveRecord::Migration
  def up
    rename_table :tile_map, :tile_map_old

    create_table :tile_map, :id => false do |t|
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
      t.string :block_group_id, :limit => 25, :encode => :lzo
    end
    grant_select :tile_map

    execute "INSERT INTO tile_map(malibu_tile_id, tile_id, normalized_lat,
      normalized_lon, state_id, zip, dma, city_geoid, timezone, nielsen_dma, block_group_id)
      (SELECT malibu_tile_id, tile_id, normalized_lat, normalized_lon, state_id, zip, dma,
      city_geoid, timezone, nielsen_dma, block_group_id
      FROM tile_map_old);"

    drop_table :tile_map_old
  end

  def down
    drop_table :tile_map

    create_table :tile_map, :id => false, :options => 'SORTKEY (malibu_tile_id)' do |t|
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
      t.string :block_group_id, :limit => 25, :encode => :lzo
    end
    grant_select :tile_map
  end
end
