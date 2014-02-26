require 'redshift_adapter_helper'

class CreateClientDailySummariesByCreative < ActiveRecord::Migration
  def change
    create_table :client_daily_summaries_by_creative_yyyymm, :options => 'SORTKEY (insertion_order_id, report_date)' do |t|
      t.date :report_date, :encode => :runlength
      t.integer :client_id, :encode => :runlength
      t.integer :advertiser_id, :encode => :bytedict
      t.string :advertiser_name, :encode => :text255
      t.integer :contract_id, :encode => :bytedict
      t.string :contract_name, :encode => :text255
      t.integer :insertion_order_id, :encode => :bytedict
      t.string :insertion_order_name, :encode => :text255
      t.integer :creative_id, :encode => :bytedict
      t.string :creative_name, :encode => :text255
      t.integer :impressions, :encode => :mostly8
      t.integer :clicks, :encode => :mostly8
      t.decimal :spend_in_dollars, :precision => 7, :scale => 2, :encode => :mostly16
    end
    grant_select :client_daily_summaries_by_creative_yyyymm
    
    create_view :client_daily_summaries_by_creative, :partitioned => :monthly
    grant_select :client_daily_summaries_by_creative
  end
end
