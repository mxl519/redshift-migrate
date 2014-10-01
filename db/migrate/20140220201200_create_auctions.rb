require 'redshift_adapter_helper'

class CreateAuctions < ActiveRecord::Migration
  def change
    # This migration was for an older system of managing partitioned tables
    # and is no longer compatible with the current partition helpers
  end

  private
  def original_change
    create_table :auctions_yyyymmdd, :id => false, :options => 'SORTKEY (report_partition, event_time)' do |t|
      t.string :tn_bid_id, :encode => :lzo
      t.string :auction_id, :encode => :lzo
      t.integer :auction_type, :encode => :runlength
      t.string :exchange, :encode => :bytedict
      t.integer :event_time, :limit => 8, :encode => :delta
      t.string :imp_0_impid, :encode => :lzo
      t.integer :imp_0_width, :encode => :runlength
      t.integer :imp_0_height, :encode => :runlength
      t.integer :imp_0_instl, :encode => :bytedict
      t.integer :imp_0_pos, :encode => :mostly8
      t.decimal :imp_0_bidfloor, :precision => 10, :scale => 7, :encode => :bytedict
      t.string :imp_0_btype_list, :encode => :lzo
      t.string :imp_0_battr_list, :encode => :lzo
      t.string :imp_0_mime_type_list, :encode => :lzo
      t.string :imp_0_expand_dir, :encode => :lzo
      t.integer :imp_0_api, :limit => 2, :encode => :runlength
      t.integer :is_app, :limit => 2, :encode => :runlength
      t.string :a_s_id, :encode => :lzo
      t.string :a_s_name, :encode => :lzo
      t.string :a_s_pid, :encode => :lzo
      t.string :a_s_pub, :encode => :lzo
      t.string :a_s_domain, :encode => :lzo
      t.string :a_s_page, :limit => 1023, :encode => :lzo
      t.string :a_s_cat, :encode => :lzo
      t.integer :a_s_tier, :limit => 2, :encode => :bytedict
      t.decimal :device_lat, :precision => 10, :scale => 7, :encode => :bytedict
      t.decimal :device_lon, :precision => 10, :scale => 7, :encode => :bytedict
      t.string :device_zip, :limit => 10, :encode => :text255
      t.string :device_carrier, :encode => :lzo
      t.string :device_type, :encode => :lzo
      t.string :device_ua, :encode => :lzo
      t.string :device_city, :encode => :text32k
      t.column :device_state, "CHAR(2)", :encode => :lzo
      t.column :device_country, "CHAR(3)", :encode => :lzo
      t.string :device_region, :encode => :lzo
      t.string :device_regionfips104, :encode => :lzo
      t.column :device_metro, "CHAR(3)", :encode => :bytedict
      t.string :device_make, :encode => :lzo
      t.string :device_model, :encode => :lzo
      t.string :device_os, :encode => :lzo
      t.string :device_osv, :encode => :lzo
      t.string :device_language, :encode => :lzo
      t.string :device_androidid, :encode => :lzo
      t.string :device_imei, :encode => :lzo
      t.string :device_odin, :encode => :lzo
      t.string :device_macsha1, :encode => :lzo
      t.string :device_openudid, :encode => :lzo
      t.string :device_idfa, :encode => :lzo
      t.string :device_ip, :limit => 20, :encode => :lzo
      t.string :device_ipv6, :limit => 40, :encode => :lzo
      t.string :device_dpidmd5, :encode => :lzo
      t.string :device_dpidsha1, :encode => :lzo
      t.string :device_didsha1, :encode => :lzo
      t.string :device_didmd5, :encode => :lzo
      t.integer :supports_js, :limit => 2, :encode => :runlength
      t.string :user_uid, :encode => :runlength
      t.integer :user_age, :encode => :bytedict
      t.column :user_gender, "CHAR(6)", :encode => :bytedict
      t.string :tn_user_id
      t.string :user_lat, :limit => 20, :encode => :lzo
      t.string :user_lon, :limit => 20, :encode => :lzo
      t.string :user_zip, :limit => 10, :encode => :lzo
      t.string :user_country, :encode => :lzo
      t.string :user_region, :encode => :lzo
      t.string :user_regionfips104, :encode => :lzo
      t.string :user_metro, :encode => :lzo
      t.string :user_city, :encode => :lzo
      t.integer :user_geo_type, :encode => :runlength
      t.integer :do_not_track, :limit => 2, :encode => :runlength
      t.boolean :coppa_safe, :encode => :runlength
      t.boolean :in_ipdb_geolocation, :encode => :runlength
      t.integer :location_score, :limit => 2, :encode => :bytedict
      t.integer :geo_type, :limit => 2, :encode => :bytedict
      t.string :tn_primary_app_cat, :encode => :bytedict
      t.string :tn_secondary_app_cats, :encode => :bytedict
      t.string :a_s_store_url, :encode => :bytedict
      t.string :a_s_version, :encode => :lzo
      t.string :a_s_bundle, :encode => :lzo
      t.integer :device_connection_type, :limit => 2, :encode => :bytedict
      t.string :imp_0_display_manager, :encode => :lzo
      t.string :imp_0_display_manager_version, :encode => :bytedict
      t.string :imp_0_tag_id, :encode => :lzo
      t.integer :pipeline_id, :limit => 2, :encode => :bytedict
      t.string :imp_0_api_list, :encode => :lzo
      t.timestamp :report_partition, :encode => :runlength
      t.string :tn_app_id, :limit => 1024, :encode => :lzo
      t.string :gc_profile_states, :limit => 512, :encode => :lzo
      t.string :gc_profile_dmas, :limit => 1024, :encode => :lzo
      t.integer :mraid_version, :encode => :runlength
      t.string :user_household_income, :limit => 64, :encode => :lzo
      t.string :a_s_tn_domain, :encode => :lzo
    end
    grant_select :auctions_yyyymmdd
    
    create_view :auctions, :partitioned => :weekly
    grant_select :auctions
  end
end
