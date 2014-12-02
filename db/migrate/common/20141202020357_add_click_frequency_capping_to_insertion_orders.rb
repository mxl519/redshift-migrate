class AddClickFrequencyCappingToInsertionOrders < ActiveRecord::Migration
  def change
    add_column :insertion_orders, :max_user_clicks_per_period, :integer, :encode => :lzo
    add_column :insertion_orders, :click_frequency_capping, :string, :encode => :bytedict
  end
end
