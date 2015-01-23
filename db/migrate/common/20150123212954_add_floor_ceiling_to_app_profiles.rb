class AddFloorCeilingToAppProfiles < ActiveRecord::Migration
  def change
    add_column :app_profiles, :bid_floor, :integer, :encode => :lzo
    add_column :app_profiles, :bid_ceiling, :integer, :encode => :lzo
  end
end
