class UpdateTargetingProfilesSize < ActiveRecord::Migration
  def up 
    rename_column :targeting_profiles, :blacklisted_app_names, :blacklisted_app_names_old
    add_column    :targeting_profiles, :blacklisted_app_names, :string, :limit => 2000, :encode => :text32k    
    rename_column :targeting_profiles, :whitelisted_app_names, :whitelisted_app_names_old
    add_column    :targeting_profiles, :whitelisted_app_names, :string, :limit => 2000, :encode => :text32k
    rename_column :targeting_profiles, :blacklisted_app_ids, :blacklisted_app_ids_old
    add_column    :targeting_profiles, :blacklisted_app_ids, :string, :limit => 1000, :encode => :text32k
    rename_column :targeting_profiles, :app_whitelist_new, :app_whitelist_new_old
    add_column    :targeting_profiles, :app_whitelist_new, :string, :limit => 1000, :encode => :text32k
    rename_column :targeting_profiles, :whitelisted_dmas, :whitelisted_dmas_old
    add_column    :targeting_profiles, :whitelisted_dmas, :string, :limit => 2000, :encode => :text32k
    rename_column :targeting_profiles, :hours, :hours_old
    add_column    :targeting_profiles, :hours, :string, :limit => 1000, :encode => :text32k
    execute "update targeting_profiles set hours=hours_old, blacklisted_app_names=blacklisted_app_names_old, whitelisted_app_names=whitelisted_app_names_old, 
    blacklisted_app_ids=blacklisted_app_ids_old, app_whitelist_new=app_whitelist_new_old, whitelisted_dmas=whitelisted_dmas_old" 
    remove_column :targeting_profiles, :hours_old
    remove_column :targeting_profiles, :blacklisted_app_names_old
    remove_column :targeting_profiles, :whitelisted_app_names_old
    remove_column :targeting_profiles, :blacklisted_app_ids_old
    remove_column :targeting_profiles, :app_whitelist_new_old
    remove_column :targeting_profiles, :whitelisted_dmas_old
  end
  
  def down
    rename_column :targeting_profiles, :blacklisted_app_names, :blacklisted_app_names_old
    add_column    :targeting_profiles, :blacklisted_app_names, :string, :encode => :text32k    
    rename_column :targeting_profiles, :whitelisted_app_names, :whitelisted_app_names_old
    add_column    :targeting_profiles, :whitelisted_app_names, :string, :encode => :text32k
    rename_column :targeting_profiles, :blacklisted_app_ids, :blacklisted_app_ids_old
    add_column    :targeting_profiles, :blacklisted_app_ids, :string, :encode => :text32k
    rename_column :targeting_profiles, :app_whitelist_new, :app_whitelist_new_old
    add_column    :targeting_profiles, :app_whitelist_new, :string, :encode => :text32k
    rename_column :targeting_profiles, :whitelisted_dmas, :whitelisted_dmas_old
    add_column    :targeting_profiles, :whitelisted_dmas, :string, :encode => :text32k
    rename_column :targeting_profiles, :hours, :hours_old
    add_column    :targeting_profiles, :hours, :string, :encode => :text32k
    execute "update targeting_profiles set hours=hours_old, blacklisted_app_names=blacklisted_app_names_old, whitelisted_app_names=whitelisted_app_names_old, 
    blacklisted_app_ids=blacklisted_app_ids_old, app_whitelist_new=app_whitelist_new_old, whitelisted_dmas=whitelisted_dmas_old" 
    remove_column :targeting_profiles, :hours_old
    remove_column :targeting_profiles, :blacklisted_app_names_old
    remove_column :targeting_profiles, :whitelisted_app_names_old
    remove_column :targeting_profiles, :blacklisted_app_ids_old
    remove_column :targeting_profiles, :app_whitelist_new_old
    remove_column :targeting_profiles, :whitelisted_dmas_old
  end  
end