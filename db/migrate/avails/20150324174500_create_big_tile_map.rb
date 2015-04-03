class CreateBigTileMap < ActiveRecord::Migration
  def up
    create_table :big_tile_map, :id => false, :options => 'SORTKEY (tile_id)' do |t|
      t.integer :tile_id, :null => false, :encode => :delta
      t.string :state_id, :encode => :bytedict
      t.string :zip, :encode => :lzo
      t.string :dma, :encode => :bytedict
      t.string :city_geoid, :encode => :lzo
      t.string :timezone, :encode => :bytedict
      t.integer :nielsen_dma, :encode => :bytedict
    end
    grant_select :big_tile_map
  end

  def down
    drop_table :big_tile_map
  end
end
