class AddPxAppBidToAppProfiles < ActiveRecord::Migration
  def change
    add_column :app_profiles, :px_app_bid, :integer
  end
end
