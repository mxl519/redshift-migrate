class UpdateTargetingProfilesNullables < ActiveRecord::Migration
  def up
    rename_column  :targeting_profiles, :min_location_tier, :min_location_tier_old
    rename_column  :targeting_profiles, :max_location_tier, :max_location_tier_old
    add_column  :targeting_profiles, :min_location_tier, :integer, :default => 7, :null => true, :encode => :mostly8
    add_column  :targeting_profiles, :max_location_tier, :integer, :default => 9, :null => true, :encode => :mostly8
    execute "update targeting_profiles set max_location_tier=max_location_tier_old, min_location_tier=min_location_tier_old" 
    remove_column  :targeting_profiles, :min_location_tier_old
    remove_column  :targeting_profiles, :max_location_tier_old
  end
  
  def down
    rename_column  :targeting_profiles, :min_location_tier, :min_location_tier_old
    rename_column  :targeting_profiles, :max_location_tier, :max_location_tier_old
    add_column  :targeting_profiles, :min_location_tier, :integer, :default => 7, :null => false, :encode => :mostly8
    add_column  :targeting_profiles, :max_location_tier, :integer, :default => 9, :null => false, :encode => :mostly8
    execute "update targeting_profiles set max_location_tier=max_location_tier_old, min_location_tier=min_location_tier_old" 
    remove_column  :targeting_profiles, :min_location_tier_old
    remove_column  :targeting_profiles, :max_location_tier_old
  end  
end