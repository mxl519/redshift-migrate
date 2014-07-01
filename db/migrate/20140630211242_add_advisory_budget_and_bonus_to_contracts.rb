class AddAdvisoryBudgetAndBonusToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :advisory_budget, :integer
    add_column :contracts, :bonus, :integer
  end
end
