class AddNewTnUserIdToAuctionSubset < ActiveRecord::Migration
  def change
    add_column :auctions_subset, :new_tn_user_id, :string, :encode => :lzo, :partitioned => :weekly
  end
end
