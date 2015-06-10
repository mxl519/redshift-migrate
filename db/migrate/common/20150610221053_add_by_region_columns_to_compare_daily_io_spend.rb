class AddByRegionColumnsToCompareDailyIoSpend < ActiveRecord::Migration
  def change
    add_column :compare_daily_io_spend, :summaries_by_region_impressions, :integer, :encode => :mostly16
    add_column :compare_daily_io_spend, :summaries_by_region_spend, :integer
    add_column :compare_daily_io_spend, :summaries_by_region_clicks, :integer, :encode => :mostly16
  end
end
