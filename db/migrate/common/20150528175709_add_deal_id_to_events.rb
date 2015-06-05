class AddDealIdToEvents < ActiveRecord::Migration
  def change
    add_column :auctions, :deal_ids, :string, :limit => 512, :encode => :lzo, :partitioned => :weekly
    add_column :bids, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
    add_column :bids_raw, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :hourly
    add_column :clicks, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :conversions, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :impressions, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
    add_column :impressions_final, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :tracking, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :win_notices, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
  end
end
