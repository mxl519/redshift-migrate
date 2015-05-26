class AddAppAdSpaceIdToOpsTables < ActiveRecord::Migration
  def change
    add_column :auctions_subset, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
    add_column :auctions_sampled, :app_ad_space_id, :string, :encode => :lzo, :limit => 100, :partitioned => :weekly
  end
end
