class CreateEnvironicsDataAttributesTable < ActiveRecord::Migration
  def up
    create_table :environics_data_attributes, :id => false do |t|
      t.string :attribute_name, :limit => 12, :null => false, :encode => :lzo
      t.string :description, :limit => 200, :null => false, :encode => :lzo
      t.string :source, :limit => 25, :null => false, :encode => :lzo
    end
    grant_select :environics_data_attributes
  end

  def down
    drop_table :environics_data_attributes
  end
end