class AddAppFilteredAuctionsSampled < ActiveRecord::Migration

    def change
      add_column :auctions_sampled, :app_profile_filtered, :boolean, :encode => :runlength, :partitioned => :weekly
    end

end
