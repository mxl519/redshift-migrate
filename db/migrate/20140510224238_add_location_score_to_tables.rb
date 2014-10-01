class AddLocationScoreToTables < ActiveRecord::Migration
  def change
    # This migration was for an older system of managing partitioned tables
    # and is no longer compatible with the current partition helpers
  end

  private
  def original_change
    add_column :auctions, :location_score, :float, :encode => :bytedict, :partitioned => :weekly
    add_column :bids, :location_score, :float, :encode => :bytedict, :partitioned => :weekly
    add_column :impressions, :location_score, :float, :encode => :bytedict, :partitioned => :monthly
    add_column :clicks, :location_score, :float, :encode => :bytedict
    add_column :conversions, :location_score, :float, :encode => :bytedict
    add_column :tracking, :location_score, :float, :encode => :bytedict
  end
end
