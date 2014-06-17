class CreatePrototypeMmxEvents < ActiveRecord::Migration
  def change
    create_prototype_table :mmx_events, :id => false, :partitioned => :weekly,
      :options => 'SORTKEY (report_partition, event_time)' do |t|
      t.timestamp :report_partition, :encode => :runlength
      t.integer :event_time, :limit => 8, :encode => :delta
      t.integer :impression, :limit => 2, :encode => :runlength
      t.integer :click, :limit => 2, :encode => :runlength
      t.decimal :price, :precision => 10, :scale => 7, :encode => :bytedict
      t.integer :client_id, :encode => :bytedict
      t.integer :advertiser_id, :encode => :bytedict
      t.integer :campaign_id, :encode => :bytedict
      t.integer :insertion_order_id, :encode => :bytedict
      t.integer :creative_id, :encode => :bytedict
      t.integer :location_id, :encode => :bytedict
      t.string :tile_id, :encode => :text255
      t.string :geoloc, :limit => 40, :encode => :text255
      t.string :zipcode, :limit => 10, :encode => :text255
      t.integer :distance, :encode => :mostly16
      t.string :exchange, :encode => :text255
      t.string :locale, :encode => :runlength
      t.column :app_site, "CHAR(4)", :encode => :runlength
      t.string :a_s_id, :encode => :text255
      t.string :a_s_name, :encode => :text255
      t.string :a_s_pid, :encode => :text255
      t.string :a_s_pub, :encode => :text255
      t.string :a_s_domain, :encode => :text255
      t.string :device_carrier, :encode => :text255
      t.string :device_type, :encode => :text255
      t.string :a_s_topcat, :encode => :text255
      t.string :categories, :encode => :text255
      t.decimal :cpm, :precision => 5, :scale => 3, :encode => :runlength
      t.string :size, :encode => :runlength
      t.integer :bid, :limit => 2, :encode => :runlength
      t.integer :conversion, :limit => 2, :encode => :runlength
      t.integer :tier, :limit => 2, :encode => :bytedict
      t.string :granularity, :encode => :runlength
      t.string :weather_condition, :encode => :text255
      t.integer :click_index, :limit => 2, :encode => :bytedict
      t.integer :temperature, :encode => :mostly8
      t.boolean :in_centroid, :encode => :runlength
      t.decimal :bid_price, :precision => 10, :scale => 7, :encode => :bytedict
      t.string :device_city, :encode => :text32k
      t.column :device_state, "CHAR(2)", :encode => :bytedict
      t.column :device_country, "CHAR(3)", :encode => :bytedict
      t.string :device_region, :encode => :runlength
      t.column :device_metro, "CHAR(3)", :encode => :bytedict
      t.column :device_gmc, "CHAR(3)", :encode => :bytedict
      t.integer :device_cat, :encode => :runlength
      t.string :device_make, :encode => :text255
      t.string :device_model, :encode => :text255
      t.string :device_os, :encode => :text255
      t.string :device_osv, :encode => :text255
      t.integer :device_connectiontype, :encode => :bytedict
      t.string :device_language, :encode => :runlength
      t.string :a_s_keywords, :encode => :text255
      t.integer :user_age, :encode => :bytedict
      t.column :user_gender, "CHAR(6)", :encode => :bytedict
      t.string :user_lat, :limit => 20, :encode => :runlength
      t.string :user_lon, :limit => 20, :encode => :runlength
      t.string :user_zip, :limit => 10, :encode => :text255
      t.string :user_country, :encode => :text255
      t.string :user_region, :encode => :runlength
      t.string :user_metro, :encode => :runlength
      t.string :user_city, :encode => :runlength
      t.integer :user_geo_type, :encode => :runlength
      t.string :user_keywords, :limit => 1023, :encode => :text32k
      t.string :event_tag, :encode => :text255
      t.integer :all_conversion, :limit => 2, :encode => :runlength
      t.integer :app_paid, :encode => :runlength
      t.integer :tracking, :limit => 2, :encode => :runlength
      t.string :tracking_action, :encode => :runlength
      t.integer :destination_id, :encode => :bytedict
      t.integer :approx_tracking_distance, :encode => :mostly8
      t.decimal :cpc, :precision => 5, :scale => 3, :encode => :runlength
      t.string :contract_type, :encode => :runlength
      t.integer :contract_id, :encode => :bytedict
      t.string :account_manager_name, :encode => :runlength
      t.string :contract_channel, :encode => :runlength
      t.string :contract_reach, :encode => :runlength
      t.string :contract_source, :encode => :runlength
      t.decimal :bidfloor, :precision => 10, :scale => 7, :encode => :bytedict
      t.boolean :non_revenue_enabled, :encode => :runlength
      t.integer :time_on_site, :encode => :mostly16
      t.boolean :has_tn_user_id, :encode => :runlength
      t.integer :location_tier, :limit => 2, :encode => :bytedict
      t.integer :geo_type, :limit => 2, :encode => :bytedict
      t.string :tn_primary_app_cat, :encode => :bytedict
      t.string :tn_secondary_app_cats, :encode => :text255
      t.string :imp_0_api_list, :encode => :bytedict
      t.string :tn_app_id, :limit => 1024, :encode => :lzo
      t.string :gc_matched_states, :limit => 512, :encode => :lzo
      t.string :gc_matched_dmas, :limit => 1024, :encode => :lzo
      t.string :gc_profile_states, :limit => 512, :encode => :lzo
      t.string :gc_profile_dmas, :limit => 1024, :encode => :lzo
      t.string :a_s_store_url, :encode => :lzo
      t.string :a_s_version, :encode => :lzo
      t.string :a_s_bundle, :encode => :lzo
      t.integer :auction_type, :encode => :runlength
      t.string :imp_0_display_manager, :encode => :lzo
      t.string :imp_0_display_manager_version, :encode => :lzo
      t.string :imp_0_tag_id, :encode => :lzo
      t.integer :tracking_accuracy, :limit => 8, :encode => :delta
      t.boolean :location_fetch_enabled, :encode => :runlength
    end
  end
end
