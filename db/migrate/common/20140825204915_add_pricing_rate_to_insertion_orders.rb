class AddPricingRateToInsertionOrders < ActiveRecord::Migration
  def change
    add_column :insertion_orders, :pricing_rate, :integer, :encode => :runlength
  end
end
