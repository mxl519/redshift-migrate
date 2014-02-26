require 'redshift_adapter_helper'

class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions_yyyymm, :options => 'DISTSTYLE KEY DISTKEY(tn_bid_id) SORTKEY (report_partition, event_time)' do |t|
      t.string :request_id, :encode => :lzo
      t.integer :event_time, :limit => 8, :encode => :delta
      t.string :locale, :encode => :runlength
      t.string :exchange, :encode => :text255
      t.string :tn_bid_id, :encode => :lzo
      t.integer :client_id, :encode => :bytedict
      t.integer :advertiser_id, :encode => :bytedict
      t.integer :contract_id, :encode => :bytedict
      t.integer :insertion_order_id, :encode => :bytedict
      t.integer :campaign_id, :encode => :bytedict
      t.integer :creative_id, :encode => :bytedict
      t.integer :location_id, :encode => :bytedict
      t.integer :distance, :encode => :mostly16
      t.string :categories, :encode => :text255
      t.integer :bid_timestamp, :limit => 8, :encode => :delta
      t.boolean :exploratory, :encode => :runlength
      t.decimal :price, :precision => 10, :scale => 7, :encode => :bytedict
      t.string :auction_id, :encode => :lzo
      t.decimal :bid_price, :precision => 10, :scale => 7, :encode => :bytedict
      t.integer :destination_id, :encode => :bytedict
      t.string :tile_id, :encode => :text255
      t.boolean :in_centroid, :encode => :runlength
      t.string :weather_condition, :encode => :text255
      t.integer :temperature, :encode => :mostly8
      t.integer :uv_index, :limit => 2, :encode => :mostly8
      t.integer :tier, :limit => 2, :encode => :bytedict
      t.decimal :device_lat, :precision => 10, :scale => 7, :encode => :bytedict
      t.decimal :device_lon, :precision => 10, :scale => 7, :encode => :bytedict
      t.string :device_zip, :limit => 10, :encode => :text255
      t.integer :location_score, :limit => 2, :encode => :bytedict
      t.integer :bid_frequency, :limit => 2, :encode => :bytedict
      t.string :imp_0_impid, :encode => :runlength
      t.string :imp_0_size, :encode => :runlength
      t.integer :imp_0_pos, :encode => :mostly8
      t.decimal :imp_0_bidfloor, :precision => 10, :scale => 7, :encode => :bytedict
      t.integer :imp_0_instl, :limit => 2, :encode => :bytedict
      t.string :imp_0_btype, :encode => :text255
      t.string :imp_0_battr, :encode => :text255
      t.integer :imp_0_api, :limit => 2, :encode => :bytedict
      t.string :device_carrier, :encode => :text255
      t.string :device_type, :encode => :text255
      t.string :device_ua, :encode => :text255
      t.integer :device_cat, :encode => :runlength
      t.string :device_make, :encode => :text255
      t.string :device_model, :encode => :text255
      t.string :device_os, :encode => :text255
      t.string :device_osv, :encode => :text255
      t.string :device_city, :encode => :text32k
      t.column :device_state, "CHAR(2)", :encode => :bytedict
      t.column :device_country, "CHAR(3)", :encode => :bytedict
      t.string :device_region, :encode => :runlength
      t.string :device_regionfips104, :encode => :runlength
      t.column :device_metro, "CHAR(3)", :encode => :bytedict
      t.column :device_gmc, "CHAR(3)", :encode => :bytedict
      t.string :device_ip, :limit => 20, :encode => :text255
      t.string :device_ipv6, :limit => 40, :encode => :runlength
      t.string :device_macsha1, :encode => :runlength
      t.string :device_openudid, :encode => :runlength
      t.string :device_idfa, :encode => :runlength
      t.string :device_androidid, :encode => :runlength
      t.string :device_imei, :encode => :runlength
      t.string :device_odin, :encode => :runlength
      t.string :device_didsha1, :encode => :runlength
      t.string :device_didmd5, :encode => :runlength
      t.string :device_dpidmd5, :encode => :runlength
      t.string :device_dpidsha1, :encode => :runlength
      t.string :device_dmacmd5, :encode => :runlength
      t.integer :device_connectiontype, :encode => :bytedict
      t.string :device_language, :encode => :runlength
      t.boolean :do_not_track, :encode => :runlength
      t.integer :geo_type, :limit => 2, :encode => :bytedict
      t.boolean :is_app, :encode => :runlength
      t.string :a_s_id, :encode => :text255
      t.string :a_s_name, :encode => :text255
      t.string :a_s_pid, :encode => :text255
      t.string :a_s_pub, :encode => :text255
      t.string :a_s_domain, :encode => :text255
      t.string :a_s_page, :limit => 1023, :encode => :text32k
      t.string :a_s_topcat, :encode => :text255
      t.string :a_s_keywords, :encode => :text255
      t.integer :app_paid, :encode => :runlength
      t.integer :app_ctr_score, :limit => 2, :encode => :bytedict
      t.integer :brandsafe_score, :limit => 2, :encode => :bytedict
      t.string :tn_user_id, :encode => :lzo
      t.string :user_uid, :encode => :runlength
      t.integer :user_age, :encode => :bytedict
      t.column :user_gender, "CHAR(6)", :encode => :bytedict
      t.string :user_lat, :limit => 20, :encode => :runlength
      t.string :user_lon, :limit => 20, :encode => :runlength
      t.string :user_zip, :limit => 10, :encode => :text255
      t.string :user_country, :encode => :text255
      t.string :user_region, :encode => :runlength
      t.string :user_regionfips104, :encode => :runlength
      t.string :user_metro, :encode => :runlength
      t.string :user_city, :encode => :runlength
      t.integer :user_geo_type, :encode => :runlength
      t.string :user_keywords, :limit => 1023, :encode => :text32k
      t.timestamp :report_partition, :encode => :runlength
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
      t.string :a_s_tn_domain, :encode => :lzo
    end
    grant_select :impressions_yyyymm
    
    create_view :impressions, :partitioned => :monthly
    grant_select :impressions
  end
end
