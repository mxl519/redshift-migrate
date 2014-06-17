class CreatePrototypeClientDailySummariesByCreative < ActiveRecord::Migration
  def change
    create_prototype_table :client_daily_summaries_by_creative, :id => false, :partitioned => :monthly,
      :options => 'SORTKEY (insertion_order_id, report_date)' do |t|
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
      t.integer :conversions, :integer, :encode => :mostly8
      t.integer :drives, :integer, :encode => :mostly8
      t.integer :calls, :integer, :encode => :mostly8
      t.integer :urls, :integer, :encode => :mostly8
    end
  end
end
