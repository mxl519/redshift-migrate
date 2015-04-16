class ChangeEsriCensusTractDataValueSize < ActiveRecord::Migration
  def up
    add_column :esri_census_tract_data, :value_new, :decimal,
      :precision => 11, :scale => 2, :encode => :mostly32
    execute "UPDATE esri_census_tract_data set value_new = value;"
    remove_column :esri_census_tract_data, :value
    rename_column :esri_census_tract_data, :value_new, :value
  end

  def down
    add_column :esri_census_tract_data, :value_new, :decimal,
      :precision => 9, :scale => 2, :encode => :mostly32
    execute "UPDATE esri_census_tract_data set value_new = value;"
    remove_column :esri_census_tract_data, :value
    rename_column :esri_census_tract_data, :value_new, :value
  end
end
