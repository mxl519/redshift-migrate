class RemoveSortKeyAuctionsOps < ActiveRecord::Migration
  def up
    drop_table :prototype_auctions_subset
    create_prototype_table :auctions_subset, :id => false, :partitioned => :daily do |t|
      t.string :tn_user_id, :limit => 90, :encode => :lzo
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.decimal :latitude, :precision => 12, :scale => 7, :encode => :bytedict
      t.decimal :longitude, :precision => 12, :scale => 7, :encode => :bytedict
      t.integer :location_tier, :limit => 2, :encode => :bytedict
      t.integer :brandsafe_score, :limit => 2, :encode => :lzo
      t.integer :app_ctr_score, :limit => 2, :encode => :bytedict
      t.integer :no_track, :limit => 2, :encode => :runlength
      t.string :zipcode, :limit => 10, :encode => :lzo
      t.column :state, "CHAR(2)", :encode => :lzo
      t.integer :dma, :limit => 2, :encode => :lzo
      t.timestamp :report_partition, :encode => :runlength
      t.integer :pipeline_id, :limit => 2, :encode => :bytedict
      t.string :exchange, :limit => 25, :encode => :text255
      t.float :location_score, :encode => :raw
      t.integer :user_age, :encode => :bytedict
      t.column :user_gender, "CHAR(6)", :encode => :bytedict
      t.string :new_tn_user_id, :encode => :lzo
      t.string :app_ad_space_id, :encode => :lzo, :limit => 100
      t.string :tile_id, :encode => :lzo, :limit => 30
      t.string :big_tile_id, :encode => :lzo, :limit => 30
      t.integer :event_time, :limit => 8, :encode => :delta
    end
  end

  def down
    drop_table :prototype_auctions_subset
    create_prototype_table :auctions_subset, :id => false, :partitioned => :daily,
                           :options => 'SORTKEY (report_partition)' do |t|
      t.string :tn_user_id, :limit => 90, :encode => :lzo
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.decimal :latitude, :precision => 12, :scale => 7, :encode => :bytedict
      t.decimal :longitude, :precision => 12, :scale => 7, :encode => :bytedict
      t.integer :location_tier, :limit => 2, :encode => :bytedict
      t.integer :brandsafe_score, :limit => 2, :encode => :lzo
      t.integer :app_ctr_score, :limit => 2, :encode => :bytedict
      t.integer :no_track, :limit => 2, :encode => :runlength
      t.string :zipcode, :limit => 10, :encode => :lzo
      t.column :state, "CHAR(2)", :encode => :lzo
      t.integer :dma, :limit => 2, :encode => :lzo
      t.timestamp :report_partition, :encode => :runlength
      t.integer :pipeline_id, :limit => 2, :encode => :bytedict
      t.string :exchange, :limit => 25, :encode => :text255
      t.float :location_score, :encode => :raw
      t.integer :user_age, :encode => :bytedict
      t.column :user_gender, "CHAR(6)", :encode => :bytedict
      t.string :new_tn_user_id, :encode => :lzo
      t.string :app_ad_space_id, :encode => :lzo, :limit => 100
      t.string :tile_id, :encode => :lzo, :limit => 30
      t.string :big_tile_id, :encode => :lzo, :limit => 30
      t.integer :event_time, :limit => 8, :encode => :delta
    end
  end
end