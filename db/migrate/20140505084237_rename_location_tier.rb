class RenameLocationTier < ActiveRecord::Migration
  def change
    rename_column :bids, :location_score, :location_tier, :partitioned => :weekly
    rename_column :mmx_events, :location_score, :location_tier, :partitioned => :weekly
    rename_column :auctions, :location_score, :location_tier, :partitioned => :weekly
    rename_column :impressions, :location_score, :location_tier, :partitioned => :monthly
    rename_column :clicks, :location_score, :location_tier
    rename_column :tracking, :location_score, :location_tier
    rename_column :conversions, :location_score, :location_tier
    rename_column :mapsense_events, :location_score, :location_tier, :partitioned => :weekly
  end
end
