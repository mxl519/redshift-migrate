class AddAppAdSpaceIdToAvailsTables < ActiveRecord::Migration
  def change
    add_column :auctions_subset, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
    add_column :auctions_avails, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
    add_column :impressions_final, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
  end
end
