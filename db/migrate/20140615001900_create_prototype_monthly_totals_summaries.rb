class CreatePrototypeMonthlyTotalsSummaries < ActiveRecord::Migration
  def change
    create_prototype_table :monthly_totals_summaries, :id => false, :partitioned => :monthly,
      :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_date)' do |t|
      t.date :report_date, :encode => :delta
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
