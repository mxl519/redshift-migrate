class RenameAppProfiles < ActiveRecord::Migration
  def up
    rename_table :app_profiles, :app_profiles_old
    rename_table :app_profile_news, :app_profiles
  end

  def down
    rename_table :app_profiles, :app_profile_news
    rename_table :app_profiles_old, :app_profiles
  end
end
