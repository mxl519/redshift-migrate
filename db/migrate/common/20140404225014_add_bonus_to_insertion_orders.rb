class AddBonusToInsertionOrders < ActiveRecord::Migration
  def change
    add_column :insertion_orders, :bonus, :integer, :encode => :mostly16
  end
end
