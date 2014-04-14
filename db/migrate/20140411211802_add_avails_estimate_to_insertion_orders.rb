class AddAvailsEstimateToInsertionOrders < ActiveRecord::Migration
  def change
    add_column :insertion_orders, :avails_estimate, :bigint, :encode => :mostly32
    add_column :insertion_orders, :valid_through, :timestamp
  end
end
