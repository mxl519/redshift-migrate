class DeprecateOldTnUserId < ActiveRecord::Migration
  def change
    rename_column :auctions, :tn_user_id, :deprecated_tn_user_id, :partitioned => :daily
    rename_column :bids, :tn_user_id, :deprecated_tn_user_id, :partitioned => :weekly
    rename_column :bids_raw, :tn_user_id, :deprecated_tn_user_id, :partitioned => :hourly
    rename_column :clicks, :tn_user_id, :deprecated_tn_user_id, :partitioned => :monthly
    rename_column :conversions, :tn_user_id, :deprecated_tn_user_id, :partitioned => :monthly
    rename_column :impressions, :tn_user_id, :deprecated_tn_user_id, :partitioned => :weekly
    rename_column :impressions_final, :tn_user_id, :deprecated_tn_user_id, :partitioned => :monthly
    rename_column :tracking, :tn_user_id, :deprecated_tn_user_id, :partitioned => :monthly
    rename_column :win_notices, :tn_user_id, :deprecated_tn_user_id, :partitioned => :weekly

    rename_column :auctions, :new_tn_user_id, :tn_user_id, :partitioned => :daily
    rename_column :bids, :new_tn_user_id, :tn_user_id, :partitioned => :weekly
    rename_column :bids_raw, :new_tn_user_id, :tn_user_id, :partitioned => :hourly
    rename_column :clicks, :new_tn_user_id, :tn_user_id, :partitioned => :monthly
    rename_column :conversions, :new_tn_user_id, :tn_user_id, :partitioned => :monthly
    rename_column :impressions, :new_tn_user_id, :tn_user_id, :partitioned => :weekly
    rename_column :impressions_final, :new_tn_user_id, :tn_user_id, :partitioned => :monthly
    rename_column :tracking, :new_tn_user_id, :tn_user_id, :partitioned => :monthly
    rename_column :win_notices, :new_tn_user_id, :tn_user_id, :partitioned => :weekly
  end
end
