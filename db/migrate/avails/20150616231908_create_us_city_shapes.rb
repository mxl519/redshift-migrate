class CreateUsCityShapes < ActiveRecord::Migration
  def change
    create_table :us_city_shapes, :id => false do |t|
      t.string   :city_geoid, :encode => :lzo, :limit => 255
      t.string   :name, :encode => :lzo, :limit => 255
      t.string   :state_name, :encode => :text255, :limit => 255
      t.string   :state_code, :encode => :text255, :limit => 2
    end
    grant_select :us_city_shapes
  end
end
