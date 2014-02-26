require 'redshift_adapter_helper'

class CreateCompareDailyIoSpend < ActiveRecord::Migration
  def change
    create_table :compare_daily_io_spend, :options => 'DISTSTYLE KEY DISTKEY(insertion_order_id) SORTKEY (report_date, insertion_order_id)' do |t|
      t.date :report_date, :null => false, :encode => :runlength
      t.integer :insertion_order_id, :null => false, :encode => :delta
      t.integer :dynamo_impressions, :encode => :mostly16
      t.integer :dynamo_spend
      t.integer :dynamo_clicks, :encode => :mostly16
      t.integer :summaries_impressions, :encode => :mostly16
      t.integer :summaries_spend
      t.integer :summaries_clicks, :encode => :mostly16
      t.integer :mmx_impressions, :encode => :mostly16
      t.integer :mmx_spend
      t.integer :mmx_clicks, :encode => :mostly16
    end
    grant_select :compare_daily_io_spend
  end
end
