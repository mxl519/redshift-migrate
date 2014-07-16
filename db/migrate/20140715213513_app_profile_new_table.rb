class AppProfileNewTable < ActiveRecord::Migration
  def change
    create_table :app_profiles_new, :options => 'SORTKEY (id)' do |t|
      t.string :exchange, :limit => 25, :encode => :text255
      t.string :a_s_id, :limit => 80, :encode => :lzo
      t.boolean :is_app, :encode => :raw
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.string :a_s_name, :limit => 50, :encode => :lzo
      t.string :tn_primary_category, :limit => 30, :encode => :lzo
      t.string :tn_secondary_category, :limit => 65, :encode => :lzo
      t.timestamp :updated_at, :null => false
      t.integer :brand_safe_tier, :encode => :mostly16
      t.string :daily_impressions, :limit => 255, :encode => :text32k, :null => false
      t.string :daily_clicks, :limit => 255, :encode => :text32k, :null => false
      t.integer :ctr_tier, :encode => :mostly16, :null => false
      t.float :exploratory_confidence, :null => false
    end
  end

end
