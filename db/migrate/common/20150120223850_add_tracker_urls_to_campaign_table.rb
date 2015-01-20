class AddTrackerUrlsToCampaignTable < ActiveRecord::Migration
  def change
    add_column :campaigns, :tracker_urls, :text, :length => 512, :encode => :lzo
  end
end
