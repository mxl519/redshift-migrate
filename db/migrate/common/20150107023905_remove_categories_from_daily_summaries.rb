class RemoveCategoriesFromDailySummaries < ActiveRecord::Migration
  def up
    remove_column :daily_summaries, :categories, :partitioned => :monthly
  end

  def down
    add_column :daily_summaries, :categories, :string, :encode => :text255, :partitioned => :monthly
  end
end
