class DropClientIdFromDailySummaries < ActiveRecord::Migration
  def up
    remove_column :daily_summaries, :client_id, :partitioned => :monthly
  end

  def down
    add_column :daily_summaries, :client_id, :integer, :encode => :lzo, :partitioned => :monthly
  end
end
