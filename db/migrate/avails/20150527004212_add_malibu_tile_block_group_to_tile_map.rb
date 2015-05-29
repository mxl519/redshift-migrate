class AddMalibuTileBlockGroupToTileMap < ActiveRecord::Migration
  def change
    rename_table :tile_map, :tile_map_old

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

    #This table is expected to exist with data needed in the new table and
    #not already present in the old table. Creating it here
    #just for compatibility
    execute "CREATE TABLE IF NOT EXISTS temp_tile_map_data
      (
        malibu_tile_id  integer,
        tile_id         varchar(30),
        block_group_id  varchar(25)
      );"

    execute "INSERT INTO tile_map(malibu_tile_id, tile_id, normalized_lat,
      normalized_lon, state_id, zip, dma, city_geoid, timezone, nielsen_dma, block_group_id)
      (SELECT tm.tile_id, tmd.tile_id, normalized_lat, normalized_lon, state_id, zip, dma,
      city_geoid, timezone, nielsen_dma, block_group_id
      FROM tile_map_old tm LEFT OUTER JOIN temp_tile_map_data tmd
      ON tm.tile_id = tmd.malibu_tile_id);"

    drop_table :temp_tile_map_data
  end

  def down
    drop_table :tile_map_new
    rename_table :tile_map_old, :tile_map
  end
end
