class FixReportHourAuctions < ActiveRecord::Migration
  def change
    rename_column :prototype_auctions, :report_partition, :report_hour
  end
end
