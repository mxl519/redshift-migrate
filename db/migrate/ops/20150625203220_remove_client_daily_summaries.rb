class RemoveClientDailySummaries < ActiveRecord::Migration
  def up
    drop_table :prototype_client_daily_summaries
    drop_table :prototype_client_daily_summaries_by_creative
    drop_table :prototype_client_daily_summaries_by_location
    drop_table :prototype_new_client_daily_summaries
    drop_table :prototype_new_client_daily_summaries_by_creative
    drop_table :prototype_new_client_daily_summaries_by_location
  end

  def down
    create_prototype_table :client_daily_summaries, :id => false, :partitioned => :monthly,
      :options => 'SORTKEY (insertion_order_id, report_day)' do |t|
      t.date :report_day, :encode => :runlength
      t.integer :client_id, :encode => :runlength
      t.integer :advertiser_id, :encode => :bytedict
      t.string :advertiser_name, :encode => :text255
      t.integer :contract_id, :encode => :bytedict
      t.string :contract_name, :encode => :text255
      t.integer :insertion_order_id, :encode => :bytedict
      t.string :insertion_order_name, :encode => :text255
      t.integer :impressions, :encode => :mostly8
      t.integer :clicks, :encode => :mostly8
      t.decimal :spend_in_dollars, :precision => 7, :scale => 2, :encode => :mostly16
      t.integer :conversions, :encode => :mostly8
      t.integer :drives, :encode => :mostly8
      t.integer :calls, :encode => :mostly8
      t.integer :urls, :encode => :mostly8
    end
    execute "CREATE TABLE prototype_new_client_daily_summaries (LIKE prototype_client_daily_summaries);"

    create_prototype_table :client_daily_summaries_by_creative, :id => false, :partitioned => :monthly,
      :options => 'SORTKEY (insertion_order_id, report_day)' do |t|
      t.date :report_day, :encode => :runlength
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
      t.integer :conversions, :encode => :mostly8
      t.integer :drives, :encode => :mostly8
      t.integer :calls, :encode => :mostly8
      t.integer :urls, :encode => :mostly8
    end
    execute "CREATE TABLE prototype_new_client_daily_summaries_by_creative (LIKE prototype_client_daily_summaries_by_creative);"

    create_prototype_table :client_daily_summaries_by_location, :id => false, :partitioned => :monthly,
      :options => 'SORTKEY (insertion_order_id, report_day)' do |t|
      t.date :report_day, :encode => :runlength
      t.integer :client_id, :encode => :runlength
      t.integer :advertiser_id, :encode => :bytedict
      t.string :advertiser_name, :encode => :text255
      t.integer :contract_id, :encode => :bytedict
      t.string :contract_name, :encode => :text255
      t.integer :insertion_order_id, :encode => :bytedict
      t.string :insertion_order_name, :encode => :text255
      t.integer :location_id, :encode => :bytedict
      t.string :location_name, :encode => :text255
      t.integer :impressions, :encode => :mostly8
      t.integer :clicks, :encode => :mostly8
      t.decimal :spend_in_dollars, :precision => 7, :scale => 2, :encode => :mostly16
      t.integer :conversions, :encode => :mostly8
      t.integer :drives, :encode => :mostly8
      t.integer :calls, :encode => :mostly8
      t.integer :urls, :encode => :mostly8
    end
    execute "CREATE TABLE prototype_new_client_daily_summaries_by_location (LIKE prototype_client_daily_summaries_by_location);"
  end
end
