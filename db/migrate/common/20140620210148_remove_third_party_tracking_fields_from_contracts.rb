class RemoveThirdPartyTrackingFieldsFromContracts < ActiveRecord::Migration
  def change
    remove_column :contracts, :third_party_tracking
    remove_column :contracts, :third_party_tracking_name
  end
end
