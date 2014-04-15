class AddExternalActivityTable < ActiveRecord::Migration
  def change
    create_table :external_events, :options => 'SORTKEY (report_partition, timestamp)' do |t|
      t.string :name, :limit => 1024, :encode => :lzo
      t.string :script_version, :encode => :lzo
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
      t.string :app_name, :limit => 1024, :encode => :lzo
      t.integer :sample_rate, :encode => :mostly16
      t.bigint :timestamp, :encode => :delta
      t.timestamp :report_partition, :encode => :runlength
      t.string :zipcode, :limit => 16, :encode => :lzo
    end
 end 
end
