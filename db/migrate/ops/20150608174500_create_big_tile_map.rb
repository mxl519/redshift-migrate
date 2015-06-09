class CreateBigTileMap < ActiveRecord::Migration
  def change
    create_table :big_tile_map, :id => false, :options => 'DISTSTYLE ALL' do |t|
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
