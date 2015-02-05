class AddBidCeilingAndFloorToRawTables < ActiveRecord::Migration
  def change
    add_column :events_raw, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :hourly
    add_column :events_raw, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :hourly
    add_column :bids_raw, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :hourly
    add_column :bids_raw, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :hourly
  end
end
