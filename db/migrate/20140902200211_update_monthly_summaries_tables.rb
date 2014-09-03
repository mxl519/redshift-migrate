class UpdateMonthlySummariesTables < ActiveRecord::Migration
  def up
    drop_table :prototype_monthly_location_summaries_yyyymm
    create_prototype_table :monthly_location_summaries, :id => false, :partitioned => :monthly,
          :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_date)' do |t|
      t.date :report_date, :encode => :lzo
      t.string :location_name, :limit => 255, :encode => :lzo
      t.integer :impressions, :encode => :delta
      t.integer :clicks, :encode => :delta
      t.float :ctr, :encode => :bytedict
      t.float :dollar_spend, :encode => :bytedict
      t.integer :campaign_id, :encode => :lzo
      t.integer :insertion_order_id, :encode => :lzo
      t.column :contract_type, "CHAR(3)", :encode => :lzo
      t.integer :contract_id, :encode => :lzo
      t.integer :conversions, :encode => :lzo
      t.integer :call_count, :encode => :lzo
      t.integer :url_count, :encode => :lzo
      t.integer :drive_count, :encode => :lzo
    end
    drop_table :prototype_monthly_creative_summaries_yyyymm
    create_prototype_table :monthly_creative_summaries, :id => false, :partitioned => :monthly,
      :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_date)' do |t|
      t.date :report_date, :encode => :lzo
      t.string :creative_name, :limit => 255, :encode => :lzo
      t.integer :impressions, :encode => :mostly16
      t.integer :clicks, :encode => :mostly16
      t.float :ctr, :encode => :bytedict
      t.float :dollar_spend, :encode => :bytedict
      t.integer :campaign_id, :encode => :lzo
      t.integer :insertion_order_id, :encode => :lzo
      t.column :contract_type, "CHAR(3)", :encode => :lzo
      t.integer :contract_id, :encode => :lzo
      t.integer :conversions, :encode => :lzo
      t.integer :call_count, :encode => :lzo
      t.integer :url_count, :encode => :lzo
      t.integer :drive_count, :encode => :lzo
    end 
  end

  def down
    drop_table :prototype_monthly_location_summaries_yyyymm
    create_prototype_table :monthly_location_summaries, :id => false, :partitioned => :monthly,
          :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_date)' do |t|
      t.date :report_date, :encode => :lzo
      t.integer :location_id, :encode => :delta
      t.integer :impressions, :encode => :delta
      t.integer :clicks, :encode => :delta
      t.float :ctr, :encode => :bytedict
      t.float :dollar_spend, :encode => :bytedict
      t.integer :campaign_id, :encode => :lzo
      t.integer :insertion_order_id, :encode => :lzo
      t.column :contract_type, "CHAR(3)", :encode => :lzo
      t.integer :contract_id, :encode => :lzo
      t.integer :conversions, :encode => :lzo
      t.integer :call_count, :encode => :lzo
      t.integer :url_count, :encode => :lzo
      t.integer :drive_count, :encode => :lzo
    end
    drop_table :prototype_monthly_creative_summaries_yyyymm
    create_prototype_table :monthly_creative_summaries, :id => false, :partitioned => :monthly,
      :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_date)' do |t|
      t.date :report_date, :encode => :delta
      t.integer :creative_id, :encode => :runlength
      t.integer :impressions, :encode => :mostly16
      t.integer :clicks, :encode => :mostly16
      t.float :ctr, :encode => :bytedict
      t.float :dollar_spend, :encode => :bytedict
      t.integer :campaign_id, :encode => :runlength
      t.integer :insertion_order_id, :encode => :runlength
      t.column :contract_type, "CHAR(3)", :encode => :runlength
      t.integer :contract_id, :encode => :runlength
      t.integer :conversions, :encode => :runlength
      t.integer :call_count, :encode => :runlength
      t.integer :url_count, :encode => :runlength
      t.integer :drive_count, :encode => :runlength
    end
  end
end
