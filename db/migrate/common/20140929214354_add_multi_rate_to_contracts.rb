class AddMultiRateToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :multi_rate, :boolean
  end
end
