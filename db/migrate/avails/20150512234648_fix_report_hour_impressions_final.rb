class FixReportHourImpressionsFinal < ActiveRecord::Migration
  def change
    rename_column :impressions_final, :report_partition, :report_hour, :partitioned => :monthly
  end
end
