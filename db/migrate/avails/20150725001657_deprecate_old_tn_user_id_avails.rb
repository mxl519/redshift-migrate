class DeprecateOldTnUserIdAvails < ActiveRecord::Migration
  def change
    rename_column :impressions_final, :tn_user_id, :deprecated_tn_user_id, :partitioned => :monthly

    rename_column :impressions_final, :new_tn_user_id, :tn_user_id, :partitioned => :monthly
    rename_column :auctions_poi, :new_tn_user_id, :tn_user_id, :partitioned => :monthly
    rename_column :auctions_avails, :new_tn_user_id, :tn_user_id, :partitioned => :weekly
  end
end
