class AddCompetitionToBids < ActiveRecord::Migration
  def change
    add_column :bids, :competitors_count, :smallint, :encode => :mostly8, :partitioned => :weekly
    add_column :bids, :competitor_ids, :string, :limit => 512, :encode => :lzo, :partitioned => :weekly
  end
end
