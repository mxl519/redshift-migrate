class AddRequestTimesToSampledAuctions < ActiveRecord::Migration
  def change
    add_column :auctions_sampled, :request_latency, :integer, :encode => :lzo, :partitioned => :weekly
  end
end
