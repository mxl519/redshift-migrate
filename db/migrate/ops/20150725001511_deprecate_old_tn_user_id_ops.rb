class DeprecateOldTnUserIdOps < ActiveRecord::Migration
  def change
    rename_column :auctions_subset, :tn_user_id, :deprecated_tn_user_id, :partitioned => :daily
    rename_column :auctions_sampled, :tn_user_id, :deprecated_tn_user_id, :partitioned => :weekly

    rename_column :auctions_subset, :new_tn_user_id, :tn_user_id, :partitioned => :daily
    rename_column :auctions_sampled, :new_tn_user_id, :tn_user_id, :partitioned => :weekly
  end
end
