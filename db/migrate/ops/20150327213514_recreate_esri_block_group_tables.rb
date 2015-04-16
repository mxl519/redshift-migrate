class RecreateEsriBlockGroupTables < ActiveRecord::Migration
  def up
    drop_table :esri_block_groups if self.connection.table_exists?(:esri_block_groups)
    create_table :esri_block_groups, :id => false, :options => 'SORTKEY (id)' do |t|
      t.string :id, :limit => 25, :null => false, :encode => :lzo
      t.string :name, :limit => 100, :null => false, :encode => :lzo
      t.string :state_abbrev, :limit => 2, :encode => :bytedict
      t.decimal :center_lat, :precision => 9, :scale => 6, :encode => :mostly32
      t.decimal :center_lon, :precision => 9, :scale => 6, :encode => :mostly32
      t.integer :radius, :encode => :mostly16
    end
    grant_select :esri_block_groups

    drop_table :esri_block_group_data if self.connection.table_exists?(:esri_block_group_data)
    create_table :esri_block_group_data, :id => false, :options => 'SORTKEY (id, attribute_name)' do |t|
      t.string :id, :limit => 25, :null => false, :encode => :lzo
      t.string :attribute_name, :limit => 12, :null => false, :encode => :lzo
      t.decimal :value, :precision => 11, :scale => 2, :encode => :mostly32
    end
    grant_select :esri_block_group_data
  end

  def down
    drop_table :esri_block_groups
    drop_table :esri_block_group_data
  end
end