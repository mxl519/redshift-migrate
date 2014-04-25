class AddConversionsToClientDailySummaries < ActiveRecord::Migration
  def change
    add_column :client_daily_summaries_by_creative, :conversions, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries_by_creative, :drives, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries_by_creative, :calls, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries_by_creative, :urls, :integer, :encode => :mostly8, :partitioned => :monthly

    add_column :client_daily_summaries_by_location, :conversions, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries_by_location, :drives, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries_by_location, :calls, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries_by_location, :urls, :integer, :encode => :mostly8, :partitioned => :monthly

    add_column :client_daily_summaries, :conversions, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries, :drives, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries, :calls, :integer, :encode => :mostly8, :partitioned => :monthly
    add_column :client_daily_summaries, :urls, :integer, :encode => :mostly8, :partitioned => :monthly
  end
end
