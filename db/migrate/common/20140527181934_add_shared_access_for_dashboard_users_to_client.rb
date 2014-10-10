class AddSharedAccessForDashboardUsersToClient < ActiveRecord::Migration
  def change
    add_column :clients, :shared_access_for_dashboard_users, :boolean
  end
end
