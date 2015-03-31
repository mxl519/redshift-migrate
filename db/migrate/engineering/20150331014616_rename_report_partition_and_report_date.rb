class RenameReportPartitionAndReportDate < ActiveRecord::Migration
  def change
    rename_column :auctions, :report_partition, :report_hour, :partitioned => :weekly
    rename_column :bids, :report_partition, :report_hour, :partitioned => :weekly
    rename_column :clicks, :report_partition, :report_hour, :partitioned => :monthly
    rename_column :conversions, :report_partition, :report_hour, :partitioned => :monthly
    rename_column :external_events, :report_partition, :report_hour, :partitioned => :monthly
    rename_column :impressions, :report_partition, :report_hour, :partitioned => :monthly
    rename_column :impressions_final, :report_partition, :report_hour, :partitioned => :monthly
    rename_column :mapsense_events, :report_partition, :report_hour, :partitioned => :weekly
    rename_column :mmx_events, :report_partition, :report_hour, :partitioned => :weekly
    rename_column :tracking, :report_partition, :report_hour, :partitioned => :monthly
    rename_column :win_notices, :report_partition, :report_hour, :partitioned => :monthly

    rename_column :app_click_mismatches, :report_date, :report_day
    rename_column :client_daily_summaries, :report_date, :report_day, :partitioned => :monthly
    rename_column :client_daily_summaries_by_creative, :report_date, :report_day, :partitioned => :monthly
    rename_column :client_daily_summaries_by_location, :report_date, :report_day, :partitioned => :monthly
    rename_column :compare_daily_io_spend, :report_date, :report_day
    rename_column :daily_summaries, :report_date, :report_day, :partitioned => :monthly
    rename_column :daily_summaries_by_region, :report_date, :report_day, :partitioned => :monthly
    rename_column :mmx_spends, :report_date, :report_day

    rename_column :spend_pacing_histories, :report_date_in_eastern_time, :report_day_in_est, :partitioned => :monthly
  end
end
