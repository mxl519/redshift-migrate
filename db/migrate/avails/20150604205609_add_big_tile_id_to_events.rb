class AddBigTileIdToEvents < ActiveRecord::Migration
  def change
    add_column :impressions_final, :big_tile_id, :string, :encode => :lzo, :limit => 30, :partitioned => :monthly
  end
end
