class CreateClicksAndImpsByCrLoc < ActiveRecord::Migration
  def change
    create_table :clicks_and_imps_by_cr_loc, :id => false,
                 :options => 'DISTSTYLE KEY DISTKEY(insertion_order_id) SORTKEY (report_week)' do |t|
      t.date :report_week, :encode => :lzo
      t.integer :insertion_order_id, :encode => :lzo
      t.integer :campaign_id, :encode => :lzo
      t.integer :creative_id, :encode => :lzo
      t.integer :location_id, :encode => :delta32k
      t.integer :impressions, :encode => :delta
      t.integer :clicks, :encode => :lzo
      t.float   :ctr, :encode => :bytedict
      t.float   :external_spend, :encode => :bytedict
      t.integer :conversions, :encode => :lzo
      t.integer :call_count, :encode => :raw
      t.integer :url_count, :encode => :raw
      t.integer :drive_count, :encode => :raw
      t.integer :contract_id, :encode => :lzo
    end
  end
end
