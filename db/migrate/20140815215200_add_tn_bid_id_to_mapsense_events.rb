class AddTnBidIdToMapsenseEvents < ActiveRecord::Migration
  def change
    add_column :mapsense_events, :tn_bid_id, :string, :encode => :lzo, :partitioned => :weekly
  end
end
