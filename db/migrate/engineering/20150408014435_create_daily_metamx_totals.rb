class CreateDailyMetamxTotals < ActiveRecord::Migration
  def change
    create_table :daily_metamx_totals, :id => false,
                 :options => 'DISTSTYLE KEY DISTKEY(insertion_order_id) SORTKEY (report_day)' do |t|
      t.date :report_day, :encode => :runlength
      t.integer :insertion_order_id, :encode => :lzo
      t.integer :total_impressions, :encode => :lzo
      t.integer :total_clicks, :encode => :lzo
      t.integer :total_spend, :limit => 8, :encode => :lzo
    end
  end
end
