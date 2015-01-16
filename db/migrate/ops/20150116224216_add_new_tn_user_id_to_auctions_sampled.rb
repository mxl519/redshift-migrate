class AddNewTnUserIdToAuctionsSampled < ActiveRecord::Migration

  def change
    add_column :auctions_sampled, :new_tn_user_id, :string, :encode => :lzo, :partitioned => :weekly
  end

end
