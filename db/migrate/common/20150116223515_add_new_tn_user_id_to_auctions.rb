class AddNewTnUserIdToAuctions < ActiveRecord::Migration

  def change
    add_column :auctions, :new_tn_user_id, :string, :encode => :lzo, :partitioned => :weekly
  end

end
