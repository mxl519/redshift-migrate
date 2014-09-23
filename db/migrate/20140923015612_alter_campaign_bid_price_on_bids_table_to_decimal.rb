class AlterCampaignBidPriceOnBidsTableToDecimal < ActiveRecord::Migration
  def up
    remove_column :bids, :campaign_bid_price, :partitioned => :weekly
    remove_column :bids_raw, :campaign_bid_price, :partitioned => :hourly
    add_column :bids, :campaign_bid_price, :decimal, :precision => 10, :scale => 7, :encode => :bytedict,
               :partitioned => :weekly
    add_column :bids_raw, :campaign_bid_price, :decimal, :precision => 10, :scale => 7, :encode => :bytedict,
               :partitioned => :hourly

  end
  def down
    remove_column :bids, :campaign_bid_price, :partitioned => :weekly
    remove_column :bids_raw, :campaign_bid_price, :partitioned => :hourly
    add_column :bids, :campaign_bid_price, :float, :partitioned => :weekly
    add_column :bids_raw, :campaign_bid_price, :float, :partitioned => :hourly
  end
end
