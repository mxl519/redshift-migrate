class AddSegmentsToDailySummariesByRegion < ActiveRecord::Migration
  def change
    add_column :daily_summaries_by_region, :segments, :string, :encode => :lzo, :partitioned => :monthly
  end
end
