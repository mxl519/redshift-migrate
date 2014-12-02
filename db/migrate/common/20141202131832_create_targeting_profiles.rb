class CreateTargetingProfiles < ActiveRecord::Migration
  def up
    create_table :targeting_profiles, :options => 'SORTKEY (campaign_id)' do |t|
      t.integer :campaign_id, :encode => :delta
      t.integer :app_whitelist_tier, :default => 0, :null => false, :encode => :mostly8
      t.integer :app_blacklist_threshold, :default => 0, :null => false, :encode => :mostly8
      t.string :exchanges, :encode => :text255
      t.string :tiers, :encode => :text255
      t.string :blacklisted_categories, :encode => :text255
      t.string :whitelisted_categories, :encode => :text255
      t.string :blacklisted_devices, :encode => :text255
      t.string :whitelisted_devices, :encode => :text255
      t.string :device_countries, :encode => :text32k
      t.string :blacklisted_app_names, :encode => :text32k
      t.string :whitelisted_app_names, :encode => :text32k
      t.string :blacklisted_app_ids, :encode => :text32k
      t.string :app_whitelist_new, :encode => :text32k
      t.string :blacklisted_carriers, :encode => :text255
      t.string :whitelisted_carriers, :encode => :text255
      t.string :whitelisted_states, :encode => :text255
      t.string :whitelisted_dmas, :encode => :text32k
      t.string :whitelisted_genders, :lzo
      t.boolean :needs_tn_user_id, :default => false, :null => false
      t.integer :min_location_tier, :default => 7, :null => false, :encode => :mostly8
      t.integer :max_location_tier, :default => 9, :null => false, :encode => :mostly8
      t.integer :min_age, :default => nil, :null => true, :encode => :mostly8
      t.integer :max_age, :default => nil, :null => true, :encode => :mostly8
      t.boolean :location_fetch_enabled, :default => false, :null => false
      t.integer :min_location_score, :default => nil, :null => true, :encode => :mostly8
      t.integer :max_location_score, :default => nil, :null => true, :encode => :mostly8
      t.string :hours, :encode => :text255
      t.string :weather, :encode => :text255
      t.string :pollen_count, :encode => :text255
      t.integer :min_temperature, :encode => :mostly8
      t.integer :max_temperature, :encode => :mostly8
      t.integer :min_uv_index, :encode => :mostly8
      t.integer :max_uv_index, :encode => :mostly8
      t.timestamp :created_at, :encode => :lzo
      t.timestamp :updated_at, :encode => :lzo
    end
    grant_select :targeting_profiles
  end

  def down
    drop_table :targeting_profiles
  end
end