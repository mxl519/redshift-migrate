class AddLocationFetchEnabledToTables < ActiveRecord::Migration
  def change
    # This migration was for an older system of managing partitioned tables
    # and is no longer compatible with the current partition helpers
  end

  private
  def original_change
    add_column :auctions, :location_fetch_enabled, :boolean, :encode => :runlength, :partitioned => :weekly
    add_column :bids, :location_fetch_enabled, :boolean, :encode => :runlength, :partitioned => :weekly
    add_column :impressions, :location_fetch_enabled, :boolean, :encode => :runlength, :partitioned => :monthly
    add_column :clicks, :location_fetch_enabled, :boolean, :encode => :runlength
    add_column :conversions, :location_fetch_enabled, :boolean, :encode => :runlength
    add_column :tracking, :location_fetch_enabled, :boolean, :encode => :runlength
    add_column :mmx_events, :location_fetch_enabled, :boolean, :encode => :runlength, :partitioned => :weekly
  end
end
