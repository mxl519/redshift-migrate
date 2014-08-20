class AddMapsEnabledToModels < ActiveRecord::Migration
  def change
    add_column :clients, :maps_enabled, :boolean, :default => false    
    add_column :advertisers, :maps_enabled, :boolean, :default => false
    add_column :contracts, :maps_enabled, :boolean, :default => false
  end
end
