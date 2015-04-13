class CreatePrototypeAuctionsAvails < ActiveRecord::Migration
  def change
    create_prototype_table :auctions_avails, :id => false, :partitioned => :weekly,
                           :options => 'DISTSTYLE KEY DISTKEY(user_profile_join_key)' do |t|
      t.string :tn_bid_id, :limit => 40, :encode => :lzo
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.timestamp :report_hour, :encode => :lzo
      t.string :exchange, :limit => 25, :encode => :text255
      t.integer :imp_0_width, :encode => :lzo
      t.integer :imp_0_height, :encode => :lzo
      t.string :imp_0_api_list, :limit => 10, :encode => :lzo
      t.string :imp_0_battr_list, :limit => 40, :encode => :lzo
      t.integer :a_s_tier, :limit => 2, :encode => :lzo
      t.integer :brandsafe_score, :limit => 2, :encode => :lzo
      t.decimal :device_lat, :precision => 12, :scale => 7, :encode => :mostly32
      t.decimal :device_lon, :precision => 12, :scale => 7, :encode => :mostly32
      t.string :device_type, :limit => 25, :encode => :lzo
      t.integer :pipeline_id, :limit => 2, :encode => :lzo
      t.string :new_tn_user_id, :encode => :lzo
      t.integer :location_tier, :limit => 2, :encode => :lzo
      t.float :location_score, :encode => :raw
      t.integer :is_app, :limit => 2, :encode => :lzo
      t.integer :supports_js, :limit => 2, :encode => :lzo
      t.integer :user_age, :encode => :delta
      t.column :user_gender, "CHAR(6)", :encode => :bytedict
      t.string :user_profile_join_key, :encode => :lzo
      
    end
  end
end