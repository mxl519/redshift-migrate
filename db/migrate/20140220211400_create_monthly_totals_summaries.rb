require 'redshift_adapter_helper'

class CreateMonthlyTotalsSummaries < ActiveRecord::Migration
  def change
    create_table :monthly_totals_summaries_yyyymm, :id => false, :options => 'DISTSTYLE KEY DISTKEY(contract_id) SORTKEY (report_date)' do |t|
      t.date :report_date, :encode => :delta
      t.integer :impressions, :encode => :mostly16
      t.integer :clicks, :encode => :mostly16
      t.column :ctr, "DOUBLE PRECISION", :encode => :bytedict
      t.column :dollar_spend, "DOUBLE PRECISION", :encode => :bytedict
      t.integer :campaign_id, :encode => :runlength
      t.integer :insertion_order_id, :encode => :runlength
      t.column :contract_type, "CHAR(3)", :encode => :runlength
      t.integer :contract_id, :encode => :runlength
      t.integer :conversions, :encode => :runlength
      t.integer :call_count, :encode => :runlength
      t.integer :url_count, :encode => :runlength
      t.integer :drive_count, :encode => :runlength
    end
    grant_select :monthly_totals_summaries_yyyymm
    
    create_view :monthly_totals_summaries, :partitioned => :monthly
    grant_select :monthly_totals_summaries
  end
end
