class AddBrandsafeScoreToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :brandsafe_score, :integer, :limit => 2, :encode => :bytedict, :partitioned => :weekly
  end
end
