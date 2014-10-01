class AddBrandsafeScoreToAuctions < ActiveRecord::Migration
  def change
    # This migration was for an older system of managing partitioned tables
    # and is no longer compatible with the current partition helpers
  end

  private
  def original_change
    add_column :auctions, :brandsafe_score, :integer, :limit => 2, :encode => :bytedict, :partitioned => :weekly
  end
end
