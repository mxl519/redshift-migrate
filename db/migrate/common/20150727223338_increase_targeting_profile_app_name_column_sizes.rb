class IncreaseTargetingProfileAppNameColumnSizes < ActiveRecord::Migration
  def up
    rename_column :targeting_profiles, :whitelisted_app_names, :whitelisted_app_names_old
    add_column    :targeting_profiles, :whitelisted_app_names, :string, :limit => 65000, :encode => :text32k

    rename_column :targeting_profiles, :blacklisted_app_names, :blacklisted_app_names_old
    add_column    :targeting_profiles, :blacklisted_app_names, :string, :limit => 65000, :encode => :text32k

    execute %(
      UPDATE targeting_profiles
      SET whitelisted_app_names=whitelisted_app_names_old, blacklisted_app_names=blacklisted_app_names_old
    )

    remove_column :targeting_profiles, :whitelisted_app_names_old
    remove_column :targeting_profiles, :blacklisted_app_names_old
  end

  def down
    rename_column :targeting_profiles, :whitelisted_app_names, :whitelisted_app_names_old
    add_column    :targeting_profiles, :whitelisted_app_names, :string, :limit => 2000, :encode => :text32k

    rename_column :targeting_profiles, :blacklisted_app_names, :blacklisted_app_names_old
    add_column    :targeting_profiles, :blacklisted_app_names, :string, :limit => 2000, :encode => :text32k

    execute %(
      UPDATE targeting_profiles
      SET whitelisted_app_names=whitelisted_app_names_old, blacklisted_app_names=blacklisted_app_names_old
    )

    remove_column :targeting_profiles, :whitelisted_app_names_old
    remove_column :targeting_profiles, :blacklisted_app_names_old
  end
end
