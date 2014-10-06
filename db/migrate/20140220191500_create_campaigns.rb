require 'redshift_adapter_helper'

class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns, :id => false, :options => 'SORTKEY (id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.timestamp :updated_at, :null => false
      t.references :insertion_order, :encode => :delta
      t.string :name, :encode => :lzo
      t.integer :max_bid, :encode => :bytedict
      t.string :pixel_url, :encode => :text255
      t.boolean :zipcode_enabled, :encode => :runlength
      t.boolean :many_locations, :encode => :runlength
      t.integer :locations_count, :encode => :mostly8
      t.string :campaign_urls, :limit => 1023, :encode => :text32k
      t.integer :app_blacklist_threshold, :encode => :mostly8
      t.integer :app_whitelist_tier, :encode => :mostly8
      t.boolean :conquest, :encode => :runlength
      t.boolean :paused, :encode => :runlength
      t.boolean :dynamic_radius, :encode => :runlength
      t.string :targeting, :limit => 2000, :encode => :text32k
      t.string :malibu_targeting, :limit => 2000, :encode => :text32k
      t.boolean :tracking_type_drive, :encode => :runlength
      t.boolean :tracking_type_map, :encode => :runlength
      t.boolean :tracking_type_call, :encode => :runlength
      t.boolean :tracking_type_coupon, :encode => :runlength
      t.boolean :tracking_type_call_from_banner, :encode => :runlength
      t.boolean :tracking_type_other, :encode => :runlength
      t.string :geocookie_targeting, :limit => 2000, :encode => :text32k
    end
    grant_select :campaigns
  end
end
