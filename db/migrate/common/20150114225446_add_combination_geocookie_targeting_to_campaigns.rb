class AddCombinationGeocookieTargetingToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :combination_geocookie_targeting, :string,
      :encode => :text32k, :limit => 65535
  end
end
