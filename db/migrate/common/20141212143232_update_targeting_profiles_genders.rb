class UpdateTargetingProfilesGenders < ActiveRecord::Migration
  def up
    rename_column  :targeting_profiles, :whitelisted_genders, :whitelisted_genders_old
    add_column  :targeting_profiles, :whitelisted_genders, :string, :encode => :lzo
    execute "update targeting_profiles set whitelisted_genders=whitelisted_genders_old" 
    remove_column  :targeting_profiles, :whitelisted_genders_old
    remove_column  :targeting_profiles, :lzo
  end
  
  def down
    rename_column  :targeting_profiles, :whitelisted_genders, :whitelisted_genders_old
    add_column  :targeting_profiles, :whitelisted_genders, :string
    execute "update targeting_profiles set whitelisted_genders=whitelisted_genders_old" 
    remove_column  :targeting_profiles, :whitelisted_genders_old
  end  
end