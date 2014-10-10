class AddWhiteLabeledReportToClients < ActiveRecord::Migration
  def change
    add_column :clients, :white_labeled_reports, :boolean, :default => false, :null => false
  end
end
