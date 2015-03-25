class CreateEsriCommonTables < ActiveRecord::Migration
  def up
    create_table :esri_data_attributes, :id => false, :options => 'SORTKEY (attribute_name)' do |t|
      t.string :attribute_name, :limit => 12, :null => false, :encode => :lzo
      t.string :description, :limit => 100, :encode => :lzo
      t.string :type, :limit => 12, :null => false, :encode => :bytedict
    end
    grant_select :esri_data_attributes
  end

  def down
    drop_table :esri_data_attributes
  end
end
