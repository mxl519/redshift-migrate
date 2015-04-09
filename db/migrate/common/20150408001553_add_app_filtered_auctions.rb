class AddAppFilteredAuctions < ActiveRecord::Migration

  def change
    add_column :auctions, :app_profile_filtered, :boolean, :encode => :runlength, :partitioned => :weekly
  end

end
