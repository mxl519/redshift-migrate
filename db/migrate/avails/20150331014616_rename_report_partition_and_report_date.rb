class RenameReportPartitionAndReportDate < ActiveRecord::Migration
  def change
    rename_column :auctions, :report_partition, :report_hour, :partitioned => :weekly
    rename_column :auctions_subset, :report_partition, :report_hour, :partitioned => :daily
  end
end
