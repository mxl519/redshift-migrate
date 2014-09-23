class AddCampaignPriceColumn < ActiveRecord::Migration
  def change
    rename_column :bids, :bid_price, :true_bid_price, :partitioned => :weekly
    add_column :bids, :campaign_bid_price, :float, :partitioned => :weekly
    rename_column :bids_raw, :bid_price, :true_bid_price, :partitioned => :hourly
    add_column :bids_raw, :campaign_bid_price, :float, :partitioned => :hourly
  end
end
