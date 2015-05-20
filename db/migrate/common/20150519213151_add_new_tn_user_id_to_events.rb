class AddNewTnUserIdToEvents < ActiveRecord::Migration
  def change
    add_column :bids_raw, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :hourly
    add_column :bids, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
    add_column :impressions, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :win_notices, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :impressions_final, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :clicks, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :conversions, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
    add_column :tracking, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
  end
end
