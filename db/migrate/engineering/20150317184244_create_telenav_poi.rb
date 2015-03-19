class CreateTelenavPoi < ActiveRecord::Migration
  def up
    create_table :telenav_poi, :options => 'SORTKEY (id)' do |t|
      t.string  :entity_name, :encode => :text255
      t.string  :entity_type, :encode => :text255
      t.string  :street, :encode => :text255
      t.string  :city, :encode => :text255
      t.string  :zip, :encode => :text255
      t.string  :state, :encode => :text255
      t.string  :country, :encode => :text255
      t.string  :nielsen_dma, :encode => :text255
      t.float   :latitude, :encode => :raw
      t.float   :longitude, :encode => :raw
      t.integer :normalized_lat, :encode => :lzo
      t.integer :normalized_lon, :encode => :lzo
      t.string  :timezone, :encode => :text255
      t.string  :brand_code, :encode => :text255
      t.string  :category_name, limit: 512, :encode => :text32k
      t.string  :category_id, :encode => :text32k
      t.string  :category_id_label, limit: 512, :encode => :text32k
    end
    grant_select :telenav_poi
  end

  def down
    drop_table :telenav_poi
  end
end
