class UpdateTargetingProfileColumnSizes < ActiveRecord::Migration
  def up
    rename_column :targeting_profiles, :app_whitelist_new, :app_whitelist_new_old
    add_column    :targeting_profiles, :app_whitelist_new, :string, :limit => 65000, :encode => :text32k

    rename_column :targeting_profiles, :blacklisted_app_ids, :blacklisted_app_ids_old
    add_column    :targeting_profiles, :blacklisted_app_ids, :string, :limit => 65000, :encode => :text32k

    execute %(
      UPDATE targeting_profiles
      SET app_whitelist_new=app_whitelist_new_old, blacklisted_app_ids=blacklisted_app_ids_old
    )

    remove_column :targeting_profiles, :app_whitelist_new_old
    remove_column :targeting_profiles, :blacklisted_app_ids_old
  end

  def down
    rename_column :targeting_profiles, :app_whitelist_new, :app_whitelist_new_old
    add_column    :targeting_profiles, :app_whitelist_new, :string, :limit => 22000, :encode => :text32k

    rename_column :targeting_profiles, :blacklisted_app_ids, :blacklisted_app_ids_old
    add_column    :targeting_profiles, :blacklisted_app_ids, :string, :limit => 22000, :encode => :text32k

    execute %(
      UPDATE targeting_profiles
      SET app_whitelist_new=app_whitelist_new_old, blacklisted_app_ids=blacklisted_app_ids_old
    )

    remove_column :targeting_profiles, :app_whitelist_new_old
    remove_column :targeting_profiles, :blacklisted_app_ids_old
  end
end
