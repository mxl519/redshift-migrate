class GrantOpsSelectOnAppProfilesNew < ActiveRecord::Migration
  def up
    grant_select :app_profile_news
  end

  def down
  end
end
