class CreateUsStateShapes < ActiveRecord::Migration
  def change
    create_table :us_state_shapes, :id => false do |t|
      t.string   :state_id, :encode => :text255, :limit => 255
      t.string   :name, :encode => :text255, :limit => 255
      t.string   :code, :encode => :text255, :limit => 2
    end
    grant_select :us_state_shapes
  end
end
