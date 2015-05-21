class AddAppAdSpaceIdToEvents < ActiveRecord::Migration
  def change
    add_column :bids_raw, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :hourly
    add_column :bids, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
    add_column :impressions, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :win_notices, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :impressions_final, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :clicks, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :conversions, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :tracking, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :auctions, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
  end
end
