class AddBrandsafeScoresToTargetingProfile < ActiveRecord::Migration
  def change
    add_column :targeting_profiles, :brandsafe_scores, :string, :encode => :text255
  end
end
