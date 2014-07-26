class CreateDailySummariesPrototypeTable < ActiveRecord::Migration
  def up
    drop_table :prototype_daily_summaries_yyyymm
    create_prototype_table :daily_summaries, :id => :false, :partitioned => :monthly, :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_date)' do |t|
      t.date :report_date, :encode => :lzo
      t.integer :insertion_order_id, :encode => :lzo
      t.integer :campaign_id, :encode => :lzo
      t.integer :creative_id, :encode => :lzo
      t.integer :location_id, :encode => :delta
      t.string :categories, :length => 50, :encode => :lzo
      t.integer :impressions, :encode => :bytedict
      t.integer :clicks, :encode => :lzo
      t.integer :spend_in_cents_thousand, :limit => 8, :encode => :bytedict
      t.integer :client_id, :encode => :lzo
      t.column :internal_spend, "DOUBLE PRECISION", :encode => :bytedict
      t.integer :conversions, :encode => :lzo
      t.column :contract_type, "CHAR(3)", :encode => :lzo
      t.integer :call_count, :encode => :lzo
      t.integer :url_count, :encode => :lzo
      t.integer :drive_count, :encode => :lzo
      t.integer :contract_id, :encode => :lzo
    end
  end

  def down
    drop_table :prototype_daily_summaries_yyyymm
    create_prototype_table :daily_summaries, :id => false, :partitioned => :monthly,
      :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_date)' do |t|
      t.date :report_date, :encode => :runlength
      t.integer :insertion_order_id, :encode => :runlength
      t.integer :campaign_id, :encode => :runlength
      t.integer :creative_id, :encode => :runlength
      t.integer :location_id, :encode => :delta
      t.string :categories, :encode => :text255
      t.integer :impressions, :encode => :mostly8
      t.integer :clicks, :encode => :mostly8
      t.integer :spend_in_cents_thousand, :limit => 8, :encode => :mostly16
      t.integer :client_id, :encode => :runlength
      t.column :internal_spend, "DOUBLE PRECISION", :encode => :bytedict
      t.integer :conversions, :encode => :runlength
      t.column :contract_type, "CHAR(3)", :encode => :runlength
      t.integer :call_count, :encode => :runlength
      t.integer :url_count, :encode => :runlength
      t.integer :drive_count, :encode => :runlength
      t.integer :contract_id, :encode => :runlength
    end
  end
end
