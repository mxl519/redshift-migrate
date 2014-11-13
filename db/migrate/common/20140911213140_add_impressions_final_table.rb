class AddImpressionsFinalTable < ActiveRecord::Migration
  def change
    create_prototype_table :impressions_final, :id => false, :partitioned => :monthly,
      :options => 'DISTSTYLE KEY DISTKEY(tn_bid_id) SORTKEY (report_partition, event_time)' do |t|
      t.string :request_id, :limit => 100, :encode => :lzo
      t.integer :event_time, :limit => 8, :encode => :delta
      t.string :locale, :limit => 20, :encode => :lzo
      t.string :exchange, :limit => 25, :encode => :text255
      t.string :tn_bid_id, :limit => 40, :encode => :lzo
      t.integer :client_id, :encode => :bytedict
      t.integer :advertiser_id, :encode => :bytedict
      t.integer :contract_id, :encode => :delta32k
      t.integer :insertion_order_id, :encode => :delta32k
      t.integer :campaign_id, :encode => :delta32k
      t.integer :creative_id, :encode => :delta32k
      t.integer :location_id, :encode => :lzo
      t.integer :distance, :encode => :mostly16
      t.string :categories, :limit => 50, :encode => :lzo
      t.integer :bid_timestamp, :limit => 8, :encode => :lzo
      t.boolean :exploratory, :encode => :runlength
      t.decimal :price, :precision => 10, :scale => 7, :encode => :bytedict
      t.string :auction_id, :limit => 40, :encode => :lzo
      t.decimal :bid_price, :precision => 10, :scale => 7, :encode => :bytedict
      t.integer :destination_id, :encode => :lzo
      t.string :tile_id, :limit => 30, :encode => :lzo
      t.boolean :in_centroid, :encode => :runlength
      t.string :weather_condition, :limit => 15, :encode => :lzo
      t.integer :temperature, :encode => :delta
      t.integer :uv_index, :limit => 2, :encode => :lzo
      t.integer :tier, :limit => 2, :encode => :lzo
      t.decimal :device_lat, :precision => 12, :scale => 7, :encode => :mostly32
      t.decimal :device_lon, :precision => 12, :scale => 7, :encode => :mostly32
      t.string :device_zip, :limit => 10, :encode => :lzo
      t.integer :location_tier, :limit => 2, :encode => :lzo
      t.integer :bid_frequency, :limit => 2, :encode => :lzo
      t.string :imp_0_impid, :limit => 40, :encode => :lzo
      t.string :imp_0_size, :limit => 15, :encode => :lzo
      t.integer :imp_0_pos, :encode => :lzo
      t.decimal :imp_0_bidfloor, :precision => 10, :scale => 7, :encode => :bytedict
      t.integer :imp_0_instl, :limit => 2, :encode => :lzo
      t.string :imp_0_btype, :limit => 10, :encode => :lzo
      t.string :imp_0_battr, :limit => 40, :encode => :lzo
      t.integer :imp_0_api, :limit => 2, :encode => :lzo
      t.string :device_carrier, :limit => 25, :encode => :lzo
      t.string :device_type, :limit => 25, :encode => :lzo
      t.string :device_ua, :limit => 165, :encode => :lzo
      t.integer :device_cat, :encode => :lzo
      t.string :device_make, :limit => 70, :encode => :lzo
      t.string :device_model, :limit => 80, :encode => :lzo
      t.string :device_os, :limit => 30, :encode => :lzo
      t.string :device_osv, :limit => 40, :encode => :lzo
      t.string :device_city, :limit => 50, :encode => :text32k
      t.column :device_state, "CHAR(2)", :encode => :lzo
      t.column :device_country, "CHAR(3)", :encode => :lzo
      t.string :device_region, :limit => 10, :encode => :lzo
      t.string :device_regionfips104, :limit => 20, :encode => :lzo
      t.column :device_metro, "CHAR(3)", :encode => :bytedict
      t.column :device_gmc, "CHAR(3)", :encode => :lzo
      t.string :device_ip, :limit => 20, :encode => :lzo
      t.string :device_ipv6, :limit => 40, :encode => :lzo
      t.string :device_macsha1, :limit => 70, :encode => :lzo
      t.string :device_openudid, :limit => 50, :encode => :lzo
      t.string :device_idfa, :limit => 50, :encode => :lzo
      t.string :device_androidid, :limit => 50, :encode => :lzo
      t.string :device_imei, :limit => 20, :encode => :lzo
      t.string :device_odin, :limit => 50, :encode => :lzo
      t.string :device_didsha1, :limit => 70, :encode => :lzo
      t.string :device_didmd5, :limit => 35, :encode => :lzo
      t.string :device_dpidmd5, :limit => 45, :encode => :lzo
      t.string :device_dpidsha1, :limit => 70, :encode => :lzo
      t.string :device_dmacmd5, :limit => 45, :encode => :lzo
      t.integer :device_connectiontype, :limit => 2, :encode => :delta
      t.string :device_language, :limit => 50, :encode => :lzo
      t.boolean :do_not_track, :encode => :runlength
      t.integer :geo_type, :limit => 2, :encode => :lzo
      t.boolean :is_app, :encode => :runlength
      t.string :a_s_id, :limit => 80, :encode => :lzo
      t.string :a_s_name, :limit => 50, :encode => :lzo
      t.string :a_s_pid, :limit => 70, :encode => :lzo
      t.string :a_s_pub, :limit => 70, :encode => :lzo
      t.string :a_s_domain, :limit => 80, :encode => :lzo
      t.string :a_s_page, :limit => 512, :encode => :lzo
      t.string :a_s_topcat, :limit => 50, :encode => :lzo
      t.string :a_s_keywords, :limit => 255, :encode => :lzo
      t.integer :app_paid, :encode => :lzo
      t.integer :app_ctr_score, :limit => 2, :encode => :lzo
      t.integer :brandsafe_score, :limit => 2, :encode => :lzo
      t.string :tn_user_id, :limit => 90, :encode => :lzo
      t.string :user_uid, :limit => 100, :encode => :lzo
      t.integer :user_age, :encode => :delta
      t.column :user_gender, "CHAR(6)", :encode => :bytedict
      t.string :user_lat, :limit => 20, :encode => :lzo
      t.string :user_lon, :limit => 20, :encode => :lzo
      t.string :user_zip, :limit => 10, :encode => :lzo
      t.string :user_country, :limit => 10, :encode => :lzo
      t.string :user_region, :limit => 30, :encode => :lzo
      t.string :user_regionfips104, :limit => 30, :encode => :lzo
      t.string :user_metro, :limit => 50, :encode => :lzo
      t.string :user_city, :limit => 50, :encode => :lzo
      t.integer :user_geo_type, :encode => :lzo
      t.string :user_keywords, :limit => 255, :encode => :lzo
      t.timestamp :report_partition, :encode => :lzo
      t.string :tn_primary_app_cat, :limit => 30, :encode => :lzo
      t.string :tn_secondary_app_cats, :limit => 65, :encode => :lzo
      t.string :imp_0_api_list, :limit => 10, :encode => :lzo
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.string :gc_matched_states, :limit => 512, :encode => :lzo
      t.string :gc_matched_dmas, :limit => 512, :encode => :lzo
      t.string :gc_profile_states, :limit => 512, :encode => :lzo
      t.string :gc_profile_dmas, :limit => 512, :encode => :lzo
      t.string :a_s_store_url, :limit => 100, :encode => :lzo
      t.string :a_s_version, :limit => 50, :encode => :lzo
      t.string :a_s_bundle, :limit => 30, :encode => :lzo
      t.integer :auction_type, :encode => :lzo
      t.string :imp_0_display_manager, :limit => 40, :encode => :lzo
      t.string :imp_0_display_manager_version, :limit => 50, :encode => :lzo
      t.string :imp_0_tag_id, :limit => 40, :encode => :lzo
      t.string :a_s_tn_domain, :limit => 40, :encode => :lzo
      t.boolean :location_fetch_enabled, :encode => :runlength
      t.integer :pipeline_id, :limit => 2, :encode => :lzo
      t.float :location_score, :encode => :raw
    end
  end
end
