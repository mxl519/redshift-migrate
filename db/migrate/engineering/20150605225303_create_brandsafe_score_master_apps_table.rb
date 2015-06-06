class CreateBrandsafeScoreMasterAppsTable < ActiveRecord::Migration
  def change
    create_table :brandsafe_score_master_apps, :id => false do |t|
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.integer :brandsafe_score, :encode => :mostly8
    end
  end
end
