class RemoveAppProfilesOld < ActiveRecord::Migration
  def up
    drop_table :app_profiles_old
  end

  def down
    create_table :app_profiles_old, :options => 'SORTKEY (id)' do |t|
      t.string :tn_name, :encode => :text32k, :null => false
      t.string :app_id, :encode => :text32k, :null => false
      t.string :app_name, :encode => :text32k
      t.string :tn_primary_category, :encode => :text255
      t.string :tn_secondary_categories, :encode => :text32k
      t.timestamp :updated_at, :null => false
      t.float :even_app_impression_factor
      t.integer :brand_safe_tier, :encode => :mostly16
      t.string :daily_impressions, :encode => :text32k, :null => false
      t.string :daily_clicks, :encode => :text32k, :null => false
      t.integer :ctr_tier, :encode => :mostly16, :null => false
      t.float :exploratory_confidence, :null => false
    end
    grant_select :app_profiles_old
  end
end
