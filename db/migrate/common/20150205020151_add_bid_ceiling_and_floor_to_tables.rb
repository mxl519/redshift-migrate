class AddBidCeilingAndFloorToTables < ActiveRecord::Migration
  def change
    add_column :bids, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :weekly
    add_column :bids, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :weekly
    add_column :auctions, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :weekly
    add_column :auctions, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :weekly
    add_column :impressions, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :impressions, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :clicks, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :clicks, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :conversions, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :conversions, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :tracking, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :tracking, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :impressions_final, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :impressions_final, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :win_notices, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :monthly
    add_column :win_notices, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :monthly
  end
end
