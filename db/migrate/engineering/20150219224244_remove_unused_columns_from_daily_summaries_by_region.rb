class RemoveUnusedColumnsFromDailySummariesByRegion < ActiveRecord::Migration
  def change
    remove_column :prototype_daily_summaries_by_region, :categories
    remove_column :prototype_daily_summaries_by_region, :client_id
  end
end
