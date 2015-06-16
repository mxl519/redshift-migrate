class AddBrandsafeScoresToTargetingProfile < ActiveRecord::Migration
  def change
    add_column :targeting_profiles, :brandsafe_scores, :text, :encode => :text255
  end
end
