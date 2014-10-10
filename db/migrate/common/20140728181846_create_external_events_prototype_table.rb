class CreateExternalEventsPrototypeTable < ActiveRecord::Migration
  def change
    create_prototype_table :external_events, :id => false, :options => 'SORTKEY (report_partition, timestamp)', :partitioned => :monthly do |t|
      t.string :name, :limit => 512, :encode => :lzo
      t.string :script_version, :limit => 255, :encode => :lzo
      t.string :client_uuid, :limit => 1024, :encode => :lzo
      t.string :true_lat_lon, :limit => 512, :encode => :lzo
      t.string :true_source, :limit => 512, :encode => :lzo
      t.string :exchange, :limit => 512, :encode => :lzo
      t.string :external_lat_lon, :limit => 512, :encode => :lzo
      t.string :url, :limit => 2048, :encode => :lzo
      t.string :user_agent, :limit => 2048, :encode => :lzo
      t.string :app_id, :limit => 1024, :encode => :lzo
      t.string :unique_id, :limit => 1024, :encode => :lzo
      t.string :external_campaign_id, :limit => 1024, :encode => :lzo
      t.string :external_creative_id, :limit => 1024, :encode => :lzo
      t.string :extra_params, :limit => 2048, :encode => :lzo
      t.string :app_name, :limit => 512, :encode => :lzo
      t.integer :sample_rate, :encode => :mostly16
      t.integer :timestamp, :limit => 8, :encode => :delta
      t.timestamp :report_partition, :encode => :runlength
      t.string :zipcode, :limit => 16, :encode => :lzo
      t.string :carrier, :limit => 512, :encode => :lzo
      t.string :location_target_id, :limit => 1024, :encode => :lzo
      t.string :geo_type, :limit => 256, :encode => :lzo
    end
  end

end
