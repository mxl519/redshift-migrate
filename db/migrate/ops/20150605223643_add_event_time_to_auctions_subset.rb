class AddEventTimeToAuctionsSubset < ActiveRecord::Migration
  def change
    add_column :auctions_subset, :event_time, :integer, :limit => 8, :encode => :delta, :partitioned => :weekly
  end
end
