class CreateAuctionsPoiTable < ActiveRecord::Migration
  def change
    create_prototype_table :auctions_poi, :id => false, :partitioned => :monthly,
                           :options => 'DISTSTYLE KEY DISTKEY(new_tn_user_id)' do |t|
      t.timestamp :report_hour, :encode => :lzo
      t.string :new_tn_user_id, :encode => :lzo
      t.decimal :latitude, :precision => 8, :scale => 5, :encode => :mostly32
      t.decimal :longitude, :precision => 8, :scale => 5, :encode => :mostly32
      t.integer :location_score_bucket, :encode => :lzo
      t.integer :seen_count, :encode => :lzo
    end
  end
end