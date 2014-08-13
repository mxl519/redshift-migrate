class AddThirdPartyTrackingVerifiedToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :third_party_tracking_verified, :boolean, default: false, null: false
  end
end
