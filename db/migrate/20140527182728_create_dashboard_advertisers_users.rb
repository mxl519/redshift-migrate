class CreateDashboardAdvertisersUsers < ActiveRecord::Migration
  def change
    create_table :dashboard_advertisers_users, :id => false do |t|
      t.belongs_to :user
      t.belongs_to :advertiser
    end
    grant_select :dashboard_advertisers_users
  end
end
