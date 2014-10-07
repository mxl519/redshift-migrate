class AddHasDashboardAccessToUser < ActiveRecord::Migration
  def change
    add_column :users, :has_dashboard_access, :boolean
  end
end
