class FixReportHourAuctionsSampledOps < ActiveRecord::Migration
  def change
    rename_column :prototype_auctions_sampled, :report_partition, :report_hour
  end
end
