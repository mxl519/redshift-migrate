class AddDealIdToEventsAvails < ActiveRecord::Migration
  def change
    add_column :auctions, :deal_ids, :string, :limit => 512, :encode => :lzo, :partitioned => :weekly
    add_column :impressions_final, :deal_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
  end
end
