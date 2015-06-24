class CreatePointsOfInterests < ActiveRecord::Migration
  def up
    create_table :points_of_interests, :options => 'SORTKEY (id)' do |t|
      t.string  :entity_name, :encode => :text255
      t.string  :street, :encode => :text255
      t.string  :city, :encode => :text255
      t.string  :postal_code, :encode => :text255
      t.string  :state, :encode => :text255
      t.string  :country, :encode => :text255
      t.string  :nielsen_dma, :encode => :text255
      t.float   :latitude, :encode => :raw
      t.float   :longitude, :encode => :raw
      t.integer :normalized_lat, :encode => :lzo
      t.integer :normalized_lon, :encode => :lzo
      t.string  :brand_code, :encode => :text255
      t.string  :category_id, :encode => :text32k
      t.string  :poi_provider, :encode => :text255
      t.integer :poi_provider_id, :encode => :lzo
    end
    grant_select :points_of_interests
  end

  def down
    drop_table :points_of_interests
  end
end
