class FixCompetitorsAndDealsAuctionsSampledOps < ActiveRecord::Migration
  def up
    rename_column :prototype_auctions_sampled, :competitor_count, :competitors_count
    remove_column :prototype_auctions_sampled, :deal_ids
  end

  def down
    add_column :prototype_auctions_sampled, :deal_ids, :string, :limit => 512, :encode => :lzo
    rename_column :prototype_auctions_sampled, :competitors_count, :competitor_count
  end
end
