class AddRequestTimesToEvents < ActiveRecord::Migration
  def change
    add_column :auctions, :request_latency, :integer, :encode => :lzo, :partitioned => :weekly
    add_column :bids_raw, :request_latency, :integer, :encode => :lzo, :partitioned => :hourly
    add_column :bids, :request_latency, :integer, :encode => :lzo, :partitioned => :weekly
  end
end
