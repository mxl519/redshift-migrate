class RemoveLocationTiersFromTargetingProfile < ActiveRecord::Migration
  def up
    remove_column :targeting_profiles, :min_location_tier
    remove_column :targeting_profiles, :max_location_tier
  end

  def down
    add_column :targeting_profiles, :min_location_tier, :integer,
      :default => 7, :null => false, :encode => :mostly8
    add_column :targeting_profiles, :max_location_tier, :integer,
      :default => 9, :null => false, :encode => :mostly8
  end
end
