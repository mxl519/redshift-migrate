class CreatePrototypeMmxAuctions < ActiveRecord::Migration
  def change
    create_prototype_table :mmx_auctions, :id => false, :partitioned => :daily,
                           :options => 'SORTKEY (report_hour, event_time)' do |t|
      t.timestamp :report_hour, :encode => :lzo
      t.integer :event_time, :limit => 8, :encode => :delta
      t.string :zipcode, :limit => 10, :encode => :lzo
      t.string :exchange, :limit => 25, :encode => :text255
      t.string :device, :limit => 25, :encode => :lzo
      t.string :size, :limit => 15, :encode => :lzo
      t.column :app_site, 'char(4)', :encode => :runlength
      t.string :a_s_id, :limit => 80, :encode => :lzo
      t.string :a_s_name, :limit => 50, :encode => :lzo
      t.string :a_s_cat, :limit => 50, :encode => :lzo
      t.string :device_model, :limit => 80, :encode => :lzo
      t.column :device_country, 'char(3)', :encode => :lzo
      t.integer :supports_js, :limit => 2, :encode => :lzo
      t.integer :dnt, :limit => 2, :encode => :runlength
      t.string :btype_list, :limit => 10, :encode => :lzo
      t.string :battr_list, :limit => 40, :encode => :lzo
      t.integer :a_s_tier, :limit => 2, :encode => :lzo
      t.decimal :bidfloor, :precision => 10, :scale => 7, :encode => :bytedict
      t.integer :location_tier, :limit => 2, :encode => :lzo
      t.integer :user_age, :encode => :delta
      t.column :user_gender, "CHAR(6)", :encode => :bytedict
      t.string :tn_primary_app_cat, :limit => 30, :encode => :lzo
      t.string :tn_secondary_app_cats, :limit => 65, :encode => :lzo
      t.integer :device_connection_type, :limit => 2, :encode => :lzo
      t.string :display_manager, :limit => 40, :encode => :lzo
      t.string :display_manager_version, :limit => 50, :encode => :lzo
      t.string :api_list, :limit => 10, :encode => :lzo
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.integer :mraid_version, :encode => :lzo
      t.integer :pipeline_id, :limit => 2, :encode => :lzo
    end
  end
end
