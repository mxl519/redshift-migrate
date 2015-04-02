class RenameReportDayInEst < ActiveRecord::Migration
  def change
    rename_column :spend_pacing_histories, :report_day_in_est, :report_day, :partitioned => :monthly
  end
end
