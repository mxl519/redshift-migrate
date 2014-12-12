class UpdateTargetingProfilesIdListSizes < ActiveRecord::Migration
  def up 
    rename_column :targeting_profiles, :blacklisted_app_ids, :blacklisted_app_ids_old
    add_column    :targeting_profiles, :blacklisted_app_ids, :string, :limit => 22000, :encode => :text32k
    rename_column :targeting_profiles, :app_whitelist_new, :app_whitelist_new_old
    add_column    :targeting_profiles, :app_whitelist_new, :string, :limit => 22000, :encode => :text32k
    rename_column :targeting_profiles, :hours, :hours_old
    add_column    :targeting_profiles, :hours, :string, :limit => 2000, :encode => :text32k
    execute "update targeting_profiles set hours=hours_old, blacklisted_app_ids=blacklisted_app_ids_old, app_whitelist_new=app_whitelist_new_old" 
    remove_column :targeting_profiles, :hours_old
    remove_column :targeting_profiles, :blacklisted_app_ids_old
    remove_column :targeting_profiles, :app_whitelist_new_old
  end
  
  def down
    rename_column :targeting_profiles, :blacklisted_app_ids, :blacklisted_app_ids_old
    add_column    :targeting_profiles, :blacklisted_app_ids, :string, :limit => 1000, :encode => :text32k
    rename_column :targeting_profiles, :app_whitelist_new, :app_whitelist_new_old
    add_column    :targeting_profiles, :app_whitelist_new, :string, :limit => 1000, :encode => :text32k
    rename_column :targeting_profiles, :hours, :hours_old
    add_column    :targeting_profiles, :hours, :string, :limit => 1000, :encode => :text32k
    execute "update targeting_profiles set hours=hours_old, blacklisted_app_ids=blacklisted_app_ids_old, app_whitelist_new=app_whitelist_new_old" 
    remove_column :targeting_profiles, :hours_old
    remove_column :targeting_profiles, :blacklisted_app_ids_old
    remove_column :targeting_profiles, :app_whitelist_new_old
  end  
end