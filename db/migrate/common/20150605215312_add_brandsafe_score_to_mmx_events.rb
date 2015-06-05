class AddBrandsafeScoreToMmxEvents < ActiveRecord::Migration
  def change
    add_column :mmx_events, :brandsafe_score, :integer, :partitioned => :weekly, :limit => 2
  end
end
