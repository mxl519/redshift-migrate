class AddCompetitionFieldsToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :competitors_count, :smallint, :encode => :mostly8, :partitioned => :weekly
    add_column :auctions, :full_competitor_ids, :string, :limit => 512, :encode => :lzo, :partitioned => :weekly
    add_column :auctions, :total_bid_frequency, :integer, :encode => :lzo, :partitioned => :weekly
  end
end
