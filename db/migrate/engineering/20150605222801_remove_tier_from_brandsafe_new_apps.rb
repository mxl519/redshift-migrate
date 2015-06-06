class RemoveTierFromBrandsafeNewApps < ActiveRecord::Migration
  def up
    remove_column :brandsafe_new_apps, :tier
  end

  def down
    add_column :brandsafe_new_apps, :tier, :integer,  :encode => :mostly8
  end
end
