class FixReportHourAuctionsSubsetOps < ActiveRecord::Migration
  def change
    rename_column :prototype_auctions_subset, :report_partition, :report_hour
  end
end
