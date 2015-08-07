class CreateVisits < ActiveRecord::Migration
  def change
    create_prototype_table :visits, :id => false, :partitioned => :monthly,
      :options => 'SORTKEY (report_hour, event_time)' do |t|
      t.string :id, :limit => 100, :encode => :lzo
      t.timestamp :report_hour, :encode => :lzo
      t.integer :event_time, :limit => 8, :encode => :lzo
      t.column :latitude, "DOUBLE PRECISION", :encode => :raw
      t.column :longitude, "DOUBLE PRECISION", :encode => :raw
      t.integer :accuracy, :encode => :bytedict
      t.column :speed, "DOUBLE PRECISION", :encode => :bytedict
      t.column :bearing, "DOUBLE PRECISION", :encode => :bytedict
      t.column :altitude, "DOUBLE PRECISION", :encode => :bytedict
      t.integer :dwell_time, :limit => 8, :encode => :lzo
      t.string :ifa, :limit => 50, :encode => :lzo
      t.string :user_agent, :limit => 165, :encode => :lzo
      t.string :os, :limit => 30, :encode => :lzo
      t.string :osv, :limit => 40, :encode => :lzo
      t.string :model, :limit => 80, :encode => :lzo
      t.string :ip, :limit => 20, :encode => :lzo
      t.string :carrier, :limit => 25, :encode => :lzo
      t.string :app_id, :limit => 80, :encode => :lzo
      t.string :app_version, :limit => 50, :encode => :lzo
      t.string :app_tracking_type, :limit => 50, :encode => :lzo
    end
  end
end
