class AddDailySummariesByRegionToOps < ActiveRecord::Migration
  def change
    create_prototype_table :daily_summaries_by_region, :id => false, :partitioned => :monthly,
                           :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_day)' do |t|
      t.date :report_day, :encode => :runlength
      t.integer :insertion_order_id, :encode => :runlength
      t.integer :campaign_id, :encode => :runlength
      t.integer :creative_id, :encode => :runlength
      t.integer :location_id, :encode => :delta
      t.integer :impressions, :encode => :mostly8
      t.integer :clicks, :encode => :mostly8
      t.integer :spend_in_cents_thousand, :limit => 8, :encode => :mostly16
      t.column :internal_spend, "DOUBLE PRECISION", :encode => :bytedict
      t.integer :conversions, :encode => :runlength
      t.column :contract_type, "CHAR(3)", :encode => :runlength
      t.integer :call_count, :encode => :runlength
      t.integer :url_count, :encode => :runlength
      t.integer :drive_count, :encode => :runlength
      t.integer :contract_id, :encode => :runlength
      t.string :state_id, :encode => :text255
      t.string :zip, :encode => :text32k
      t.string :city_geoid, :encode => :text255
      t.integer :nielsen_dma, :encode => :bytedict
      t.string :segments, :encode => :lzo
    end
  end
end