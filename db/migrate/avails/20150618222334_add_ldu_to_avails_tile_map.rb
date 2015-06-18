class AddLduToAvailsTileMap < ActiveRecord::Migration
  def change
    add_column :tile_map, :ldu, :string, :limit => 3, :encode => :lzo
  end
end
