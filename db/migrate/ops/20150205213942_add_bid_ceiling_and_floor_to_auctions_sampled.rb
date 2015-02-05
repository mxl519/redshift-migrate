class AddBidCeilingAndFloorToAuctionsSampled < ActiveRecord::Migration
  def change
    add_column :auctions_sampled, :app_profile_bid_ceiling, :integer, :encode => :bytedict, :partitioned => :weekly
    add_column :auctions_sampled, :app_profile_bid_floor, :integer, :encode => :bytedict, :partitioned => :weekly
  end
end
