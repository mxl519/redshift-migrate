class AddCostIncurringFeaturesFieldsToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :cost_incurring_features, :string, :encode => :text255
    add_column :contracts, :invoicing_notes, :string, :encode => :text255
  end
end
