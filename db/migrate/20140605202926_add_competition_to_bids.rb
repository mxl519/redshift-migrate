class AddCompetitionToBids < ActiveRecord::Migration
  def change
    # This migration was for an older system of managing partitioned tables
    # and is no longer compatible with the current partition helpers
  end

  private
  def original_change
    add_column :bids, :competitors_count, :smallint, :encode => :mostly8, :partitioned => :weekly
    add_column :bids, :competitor_ids, :string, :limit => 512, :encode => :lzo, :partitioned => :weekly
  end
end
