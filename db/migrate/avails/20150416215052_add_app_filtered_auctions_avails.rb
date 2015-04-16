class AddAppFilteredAuctionsAvails < ActiveRecord::Migration
  def change
    add_column :auctions_avails, :app_profile_filtered, :boolean, :encode => :runlength, :partitioned => :weekly
  end
end
