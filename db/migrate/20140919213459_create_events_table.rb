class CreateEventsTable < ActiveRecord::Migration
  def change
    create_prototype_table :events, :id => false, :partitioned => 'hourly', :options => 'DISTSTYLE KEY DISTKEY(tn_bid_id)' do |t|
      t.string :request_id, :limit => 100, :encode => :lzo
      t.integer :event_time, :limit => 8, :encode => :delta
      t.string :locale, :limit => 20, :encode => :lzo
      t.string :exchange, :limit => 25, :encode => :text255
      t.column :event_type, 'char(1)', :encode => :lzo
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
      t.decimal :price, :precision => 10, :scale => 7, :encode => :lzo
      t.string :event_tag, :limit => 30, :encode => :lzo
      t.integer :click_index, :limit => 2, :encode => :lzo
      t.string :click_url, :limit => 900, :encode => :lzo
      t.string :tn_udid_sha1, :limit => 70, :encode => :lzo
      t.string :tn_udid_md5, :limit => 45, :encode => :lzo
      t.string :tn_device_type, :limit => 25, :encode => :lzo
      t.string :tn_idfa, :limit => 50, :encode => :lzo
      t.string :s4a_coordinates, :limit => 50, :encode => :lzo
      t.integer :time_on_site, :encode => :lzo
      t.string :tracking_action, :limit => 50, :encode => :lzo
      t.integer :tracking_accuracy, :limit => 8, :encode => :lzo
      t.integer :count_for_attribution, :limit => 2, :encode => :runlength
    end
  end
end
