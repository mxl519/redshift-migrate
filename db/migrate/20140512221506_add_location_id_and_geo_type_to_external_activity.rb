class AddLocationIdAndGeoTypeToExternalActivity < ActiveRecord::Migration
  def change
    add_column :external_events, :location_target_id, :string, :limit => 1024, :encode => :lzo
    add_column :external_events, :geo_type, :string, :limit => 256, :encode => :lzo
  end
end
