class CreateCanadaProvinceShapes < ActiveRecord::Migration
  def change
    create_table :canada_province_shapes, :id => false do |t|
      t.string   :name, :encode => :text32k, :limit => 512
      t.string   :code, :encode => :text255, :limit => 2
    end
    grant_select :canada_province_shapes
  end
end
