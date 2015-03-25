class CreateEsriCensusTractTables < ActiveRecord::Migration
  def up
    create_table :esri_census_tracts, :id => false, :options => 'SORTKEY (id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.string :name, :limit => 100, :null => false, :encode => :lzo
      t.string :state_abbrev, :limit => 2, :encode => :bytedict
      t.decimal :center_lat, :precision => 9, :scale => 6, :encode => :mostly32
      t.decimal :center_lon, :precision => 9, :scale => 6, :encode => :mostly32
      t.integer :radius, :encode => :mostly16
    end
    grant_select :esri_census_tracts

    create_table :esri_census_tract_data, :id => false, :options => 'SORTKEY (id, attribute_name)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.string :attribute_name, :limit => 12, :null => false, :encode => :lzo
      t.decimal :value, :precision => 9, :scale => 2, :encode => :mostly32
    end
    grant_select :esri_census_tract_data
  end

  def down
    drop_table :esri_census_tracts
    drop_table :esri_census_tract_data
  end
end
